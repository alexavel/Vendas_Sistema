unit Vendas.Controller.BaseCadastro;

interface

uses
  Vendas.Interfaces.BaseCadastro, Vcl.Forms, System.Classes, Vcl.ActnList, Generics.Collections,
  Vcl.ComCtrls, RTTI, Vendas.Classes.Atributo, Data.DB, System.SysUtils, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, Vcl.Dialogs, System.Variants;
const
  csPOSICAO_LEFT_EDIT = 20;
  csPOSICAO_TOP_EDIT = 25;
  csMARGIN_TOP_EDIT = 30;

Type
  TBaseCadastroController = class(TInterfacedObject, IBaseCadastro)
  private
    FFormularioBase: TForm;
    FListaAcoes: TDicionarioAcoes;
    FListaTabSheets: TDicionarioTabSheets;
    FListaDataFrames: TDicionarioDataSourceFrame;
    FPageBaseCadasro: TPageControl;
    FAcaoAtual: TTipoAcao;
    FDataSourcePrincipal: TDataSource;
    FDBGridListagem: TDBGrid;
    FGeraEdits: Boolean;
    FFieldAutoIncremento: TField;
    procedure ColetarAtributos;
    procedure ColetarMetodoEditAtributos;
    procedure HabilitarBotoes;
    procedure SelecionarPagina;
    procedure ConfigurarBasePrincipal(ADataSource: TDataSource);
    procedure ConfigurarPaginaCadastro(lRTTIField: TRttiField);
    procedure ConfigurarGrid(lRTTIField: TRttiField);
    procedure ConfiguraAtibutos(lRTTIField: TRttiField);
    procedure AtribuirCaptionForm(const ACaptionForm: string);
    procedure GerarEditsAutomatico;
    procedure ConstruirEdit(ATabSheetCadastro: TTabSheet;
      lField: TField; var lTop, lLeft: Integer);
    procedure ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
      lField: TField; var lTop, lLeft: Integer);
    procedure AtualizarPosicaoEdits(AComponente: TComponent;
      ATabSheetCadastro: TTabSheet; var lLeft: Integer; var lTop: Integer);
    procedure AtualizarPosicaoLeftEdit(AComponente: TComponent; var lLeft: Integer);
    procedure ColetaFrames;
  protected
    procedure SelecionarCelula(Sender: TObject);
    property ListaAcoes: TDicionarioAcoes read FListaAcoes write FListaAcoes;
  public
    constructor create(AEmbedded: TForm);
    destructor Destroy; override;
    class function New(AEmbedded: TForm): IBaseCadastro;

    function IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
    function Novo: IBaseCadastro;
    function Editar: IBaseCadastro;
    function Excluir: IBaseCadastro;
    function Gravar: IBaseCadastro;
    function Cancelar: IBaseCadastro;
  end;

implementation

uses
  Vendas.Dao;

resourcestring
  csPREFIXO_CHECKBOX = 'chk%s';
  csPREFIXO_EDIT = 'edt%s';

{ TBaseCadstro }

class function TBaseCadastroController.New(AEmbedded: TForm): IBaseCadastro;
begin
  Result := Self.Create(AEmbedded)
end;

constructor TBaseCadastroController.create(AEmbedded: TForm);
begin
  FFormularioBase := AEmbedded;
  FListaAcoes:= TDicionarioAcoes.Create;
  FListaTabSheets:= TDicionarioTabSheets.Create;
  FListaDataFrames:= TDicionarioDataSourceFrame.Create;
  ColetarAtributos;
  FAcaoAtual := taBrowse;
  HabilitarBotoes;
  GerarEditsAutomatico;
  ColetarMetodoEditAtributos;
  ColetaFrames;
end;

destructor TBaseCadastroController.Destroy;
begin
  if Assigned(FListaAcoes) then
    FListaAcoes.Free;

  if Assigned(FListaTabSheets) then
    FListaTabSheets.Free;

  if Assigned(FListaDataFrames) then
    FListaDataFrames.Free;

  inherited;
end;

function TBaseCadastroController.Novo: IBaseCadastro;
begin
  FDataSourcePrincipal.DataSet.Append;
end;

function TBaseCadastroController.Editar: IBaseCadastro;
begin
  FDataSourcePrincipal.DataSet.Edit;
end;

function TBaseCadastroController.Excluir: IBaseCadastro;
begin
  FDataSourcePrincipal.DataSet.Delete;
end;

function TBaseCadastroController.Gravar: IBaseCadastro;
var
  lFrame: TFrame;
  lField: TField;
  lDataSet: TDataSet;
begin
  try
    if FDataSourcePrincipal.DataSet.State in dsEditModes then
    begin
      dmVendas.fdConetor.StartTransaction;
      FDataSourcePrincipal.DataSet.Post;
      for lFrame in FListaDataFrames.keys do
      begin
        lDataSet:= FListaDataFrames[lFrame].DataSet;
        lField := lDataSet.FindField(FFieldAutoIncremento.FieldName);
        if lDataSet.Modified then
        begin
          lDataSet.First;
          while not lDataSet.Eof do
          begin
            if lField.value <> null then
            begin
              lDataSet.Next;
              Continue;
            end;

            lDataSet.Edit;
            lField.Value := FFieldAutoIncremento.Value;
            lDataSet.post;
            lDataSet.Next;
          end;
        end;
      end;
      dmVendas.fdConetor.Commit
    end;
  Except On E:Exception do
    begin
      dmVendas.fdConetor.Rollback;
      Cancelar;
      raise Exception.Create('Houve um erro: '
                            +#13
                            +e.Message);
    end;
  end;
end;

function TBaseCadastroController.Cancelar: IBaseCadastro;
begin
  FDataSourcePrincipal.DataSet.Cancel;
end;

procedure TBaseCadastroController.AtualizarPosicaoLeftEdit(AComponente: TComponent; var lLeft: Integer);
begin
  lLeft := lLeft + TControl(AComponente).Width + csPOSICAO_LEFT_EDIT;
end;

procedure TBaseCadastroController.AtualizarPosicaoEdits(AComponente: TComponent;
      ATabSheetCadastro: TTabSheet; var lLeft: Integer; var lTop: Integer);
begin
  if ATabSheetCadastro.Width < (lLeft + TControl(AComponente).Width) then
  begin
    lLeft := ATabSheetCadastro.Left + csPOSICAO_LEFT_EDIT;
    lTop := lTop + (csPOSICAO_TOP_EDIT * 2);
  end;
end;

procedure TBaseCadastroController.HabilitarBotoes;
begin
  FListaAcoes.Items[taNovo].Enabled    := ( FAcaoAtual in csModEdicao);
  FListaAcoes.Items[taEditar].Enabled  := ( FAcaoAtual in csModEdicao) and (FDataSourcePrincipal.DataSet.RecordCount > 0);
  FListaAcoes.Items[taExcluir].Enabled := ( FAcaoAtual in csModEdicao) and (FDataSourcePrincipal.DataSet.RecordCount > 0);
  FListaAcoes.Items[taGravar].Enabled  := ( FAcaoAtual in csModPersisten);
  FListaAcoes.Items[taCancelar].Enabled:= ( FAcaoAtual in csModPersisten);
  SelecionarPagina;
end;

procedure TBaseCadastroController.SelecionarCelula(Sender: TObject);
begin
  if FDataSourcePrincipal.DataSet.IsEmpty then
    Exit;

  IniciarAcao(taEditar);
end;

procedure TBaseCadastroController.SelecionarPagina;
begin
  if FAcaoAtual in csVizualizacao then
    FPageBaseCadasro.ActivePage :=  FListaTabSheets.Items[csVizualizacao]
  else
    FPageBaseCadasro.ActivePage :=  FListaTabSheets.Items[csEdicao];
end;

function TBaseCadastroController.IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
begin
  result := Self;
  FAcaoAtual := AAcao;
  HabilitarBotoes;
  case AAcao of
    taNovo: Novo;
    taEditar: Editar;
    taExcluir: Excluir;
    taGravar: Gravar;
    taCancelar: Cancelar;
  end;
end;

procedure TBaseCadastroController.GerarEditsAutomatico;
var
  lField: TField;
  lTabSheetCadastro: TTabSheet;
  lTop, lLeft: Integer;
begin
  for lField in FDataSourcePrincipal.DataSet.Fields do
  begin
    case lField.datatype of
      ftAutoInc: FFieldAutoIncremento := lField;
    end;
  end;

  if not FGeraEdits then
    Exit;

  lTabSheetCadastro:= FListaTabSheets.Items[csEdicao];
  lTop := lTabSheetCadastro.Top + csPOSICAO_TOP_EDIT;
  lLeft:= lTabSheetCadastro.Left + csPOSICAO_LEFT_EDIT;
  for lField in FDataSourcePrincipal.DataSet.Fields do
  begin
    case lField.datatype of
      ftString, ftWideString, ftInteger, ftLargeint, ftAutoInc, ftDate, ftDateTime, ftTimeStamp:
        ConstruirEdit(lTabSheetCadastro, lField, lTop, lLeft);
      ftBoolean:
        ConstruirCheckBox(lTabSheetCadastro, lField, lTop, lLeft);
      ftFloat, ftCurrency, ftBCD:
        ConstruirEdit(lTabSheetCadastro, lField, lTop, lLeft);
    end;
  end;
end;

procedure TBaseCadastroController.ConstruirEdit(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lLabelEdit: TDBLabeledEdit;
begin
  lLabelEdit := TDBLabeledEdit.Create(ATabSheetCadastro);
  lLabelEdit.Parent := ATabSheetCadastro;
  lLabelEdit.Name := Format(csPREFIXO_EDIT,[lField.FieldName]);
  lLabelEdit.DataSource := FDataSourcePrincipal;
  lLabelEdit.DataField := lField.FieldName;
  lLabelEdit.EditLabel.Caption := lField.DisplayLabel;
  AtualizarPosicaoEdits(lLabelEdit, ATabSheetCadastro, lLeft, lTop);
  lLabelEdit.Top := lTop;
  lLabelEdit.Left := lLeft;
  lLabelEdit.AlignWithMargins := True;
  lLabelEdit.Margins.Top := csMARGIN_TOP_EDIT;
  lLabelEdit.Width := (lField.DisplayWidth * 2) + 100;
  lLabelEdit.Enabled := not lField.ReadOnly;
  lLabelEdit.MaxLength := lField.DisplayWidth;
  AtualizarPosicaoLeftEdit(lLabelEdit, lLeft);
end;

procedure TBaseCadastroController.ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lCheckBox: TDBCheckBox;
begin
  lCheckBox := TDBCheckBox.Create(ATabSheetCadastro);
  lCheckBox.Parent := ATabSheetCadastro;
  lCheckBox.Name := Format(csPREFIXO_CHECKBOX,[lField.FieldName]);
  lCheckBox.DataSource := FDataSourcePrincipal;
  lCheckBox.DataField := lField.FieldName;
  lCheckBox.Caption := lField.DisplayLabel;
  AtualizarPosicaoEdits(lCheckBox, ATabSheetCadastro, lLeft, lTop);
  lCheckBox.Top := lTop;
  lCheckBox.Left := lLeft;
  lCheckBox.AlignWithMargins := True;
  lCheckBox.Margins.Top := csMARGIN_TOP_EDIT;
  lCheckBox.Width := (lField.DisplayWidth * 2) + 100;
  lCheckBox.Enabled := not lField.ReadOnly;
  AtualizarPosicaoLeftEdit(lCheckBox, lLeft);
end;

procedure TBaseCadastroController.ConfigurarPaginaCadastro(lRTTIField: TRttiField);
begin
  if lRTTIField.GetValue(FFormularioBase).IsObject and
     (lRTTIField.GetValue(FFormularioBase).AsObject is TPageControl) then
    FPageBaseCadasro := TPageControl(lRTTIField.GetValue(FFormularioBase).AsObject);
end;

procedure TBaseCadastroController.AtribuirCaptionForm(const ACaptionForm: string);
begin
  if ACaptionForm.IsEmpty then
    FFormularioBase.Caption := '*** Não foi informado nenhum titulo para a tela ***'
  else
    FFormularioBase.Caption := ACaptionForm;
end;

procedure TBaseCadastroController.ConfiguraAtibutos(lRTTIField: TRttiField);
var
  lRTTIAtributo: TCustomAttribute;
  lAction: TAction;
  lTabSheet: TTabSheet;
begin
  for lRTTIAtributo in lRTTIField.GetAttributes do
  begin
    if lRTTIAtributo is TAcoesAtributes then
    begin
      lAction := TAction(lRTTIField.GetValue(FFormularioBase).AsObject);
      FListaAcoes.Add(TAcoesAtributes(lRTTIAtributo).TipoAcao, lAction);
    end else if lRTTIAtributo is TOperacaoAtributes then
    begin
      lTabSheet := TTabSheet(lRTTIField.GetValue(FFormularioBase).AsObject);
      FListaTabSheets.Add(TOperacaoAtributes(lRTTIAtributo).TipoOperacao, lTabSheet);
    end;
  end;
end;

procedure TBaseCadastroController.ConfigurarBasePrincipal(ADataSource: TDataSource);
begin
  FDataSourcePrincipal := ADataSource;
  if not Assigned(FDataSourcePrincipal.DataSet) then
    raise Exception.Create('Erro: Base de dados não configurada.');

  FDataSourcePrincipal.DataSet.Active := True;
end;

procedure TBaseCadastroController.ConfigurarGrid(lRTTIField: TRttiField);
var
  lField: TField;
  lColuna: TColumn;
begin
  if lRTTIField.GetValue(FFormularioBase).IsObject and
     (lRTTIField.GetValue(FFormularioBase).AsObject is TDBGrid) then
  begin
    FDBGridListagem := TDBGrid(lRTTIField.GetValue(FFormularioBase).AsObject);
    if not Assigned(FDBGridListagem.DataSource) then
      raise Exception.Create('Erro: Base de dados não configurada.');

    ConfigurarBasePrincipal(FDBGridListagem.DataSource);
    for lField in FDataSourcePrincipal.DataSet.Fields do
    begin
      lColuna := FDBGridListagem.Columns.Add;
      lColuna.Field := lField;
      lColuna.Title.Caption := lField.DisplayLabel;
      lColuna.Width := (lField.DisplayWidth * 2) + 100;
    end;
    FDBGridListagem.OnDblClick:= SelecionarCelula;
  end;
end;

procedure TBaseCadastroController.ColetaFrames;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo, lRTTITipoFrame: TRttiType;
  lRTTIField, lRTTIFieldFrame: TRttiField;
  lFrame: TFrame;
  lDataSource: TDataSource;
begin
  lDataSource := nil;
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFormularioBase.ClassType);
  for lRTTIField in lRTTITipo.GetFields do
    if lRTTIField.GetValue(FFormularioBase).IsObject and
       (lRTTIField.GetValue(FFormularioBase).AsObject is TFrame) then
    begin
      lFrame:= TFrame(lRTTIField.GetValue(FFormularioBase).AsObject);
      lRTTITipoFrame := lRTTIContexto.GetType(lFrame.ClassType);
      for lRTTIFieldFrame in lRTTITipoFrame.GetFields do
        if lRTTIFieldFrame.GetValue(lFrame).IsObject and
          (lRTTIFieldFrame.GetValue(lFrame).AsObject is TDataSource) then
        begin
          lDataSource:= TDataSource(lRTTIFieldFrame.GetValue(lFrame).AsObject);
          break
        end;
        FListaDataFrames.Add(lFrame,lDataSource)
    end;
end;

procedure TBaseCadastroController.ColetarAtributos;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo: TRttiType;
  lRTTIField: TRttiField;
  lRTTIAtributo: TCustomAttribute;
begin
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFormularioBase.ClassType);
  for lRTTIAtributo in lRTTITipo.GetAttributes do
    if lRTTIAtributo is TTituloFormAtributes then
    begin
       AtribuirCaptionForm(TTituloFormAtributes(lRTTIAtributo).CaptionForm);
       FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;
    end;

  for lRTTIField in lRTTITipo.GetFields do
  begin
    ConfigurarPaginaCadastro(lRTTIField);
    ConfigurarGrid(lRTTIField);
    ConfiguraAtibutos(lRTTIField);
  end;
end;

procedure TBaseCadastroController.ColetarMetodoEditAtributos;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo, lRTTITipoEdit: TRttiType;
  lRTTIMetodo: TRttiMethod;
  lRTTIProperty: TRttiProperty;
  lRTTIAtributo: TCustomAttribute;
  lHandlerMetodo: TMethod;  
  lNomeComponent: string;
  lLabelEditComponente: TDBLabeledEdit;
begin
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFormularioBase.ClassType);
  for lRTTIMetodo in lRTTITipo.GetMethods do
    for lRTTIAtributo in lRTTIMetodo.GetAttributes do      
      if lRTTIAtributo is TValidaCamposAtributes then
      begin
        lNomeComponent := format(csPREFIXO_EDIT,[TValidaCamposAtributes(lRTTIAtributo).NomeCampo]);
        if Assigned(FListaTabSheets.Items[csEdicao].FindComponent(lNomeComponent)) then
        begin
          lLabelEditComponente :=  TDBLabeledEdit(FListaTabSheets.Items[csEdicao].FindComponent(lNomeComponent));
          lRTTITipoEdit := lRTTIContexto.GetType(lLabelEditComponente.ClassType);
          lRTTIProperty := lRTTITipoEdit.GetProperty('OnExit');
          lHandlerMetodo.Code := lRTTIMetodo.CodeAddress;
          lHandlerMetodo.Data := lLabelEditComponente;
          lRTTIProperty.SetValue(lLabelEditComponente,TValue.From<TNotifyEvent>(TNotifyEvent(lHandlerMetodo)));          
        end;
        
        FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;
      end;
end;

end.
