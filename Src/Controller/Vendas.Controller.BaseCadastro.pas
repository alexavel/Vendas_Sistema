unit Vendas.Controller.BaseCadastro;

interface

uses
  Vendas.Interfaces.BaseCadastro, Vcl.Forms, System.Classes, Vcl.ActnList, Generics.Collections,
  Vcl.ComCtrls, RTTI, Vendas.Classes.Atributo, Data.DB, System.SysUtils, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, Vcl.Dialogs, System.Variants, FireDAC.Comp.Client;
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
    FPrimariKeyFieldBase: TField;
    FGravaAutomaticoProc: TRotinaGravaAutomatico;
    /// <summary>
    /// Faz coleta dos atributos associados ao CRUD
    /// </summary>
    procedure ColetarAtributos;
    /// <summary>
    /// Faz coleta dos métodos para atribuir a eventos dos componentes edit como: OnExit, OnEnter...
    /// </summary>
    procedure ColetarMetodoEditAtributos;
    /// <summary>
    /// Faz o controle de botões de edição do crud
    /// </summary>
    procedure HabilitarBotoes;
    /// <summary>
    /// Seleciona página de trabalho conforme ação chamada
    /// </summary>
    procedure SelecionarPagina;
    /// <summary>
    /// Configura o controle da base de dados principal do CRUD
    /// </summary>
    procedure ConfigurarBasePrincipal(ADataSource: TDataSource);
    /// <summary>
    /// Configura o controle do TPageControl do CRUD
    /// </summary>
    procedure ConfigurarPaginaCadastro(lRTTIField: TRttiField);
    /// <summary>
    /// Faz a configuração e controle do DBGrid principal da listagem
    /// </summary>
    procedure ConfigurarGrid(lRTTIField: TRttiField);
    /// <summary>
    /// Configura as ações e opreações do crud pelo atributo
    /// </summary>
    procedure ConfiguraAtibutos(lRTTIField: TRttiField);
    /// <summary>
    /// Atribui o titulo ao formulário
    /// </summary>
    procedure AtribuirCaptionForm(const ACaptionForm: string);
    /// <summary>
    /// Gera os edits automáticos
    /// </summary>
    procedure GerarEditsAutomatico;
    /// <summary>
    /// Identifica e instancia a chave primária para controle
    /// </summary>
    procedure CapturaChavePrimaria;
    /// <summary>
    /// Contrutor do componente Edit
    /// </summary>
    procedure ConstruirEdit(ATabSheetCadastro: TTabSheet;
      lField: TField; var lTop, lLeft: Integer);
    /// <summary>
    /// Contrutor do componente CheckBox
    /// </summary>
    procedure ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
      lField: TField; var lTop, lLeft: Integer);
    /// <summary>
    /// Atualiza posicionamento automático dos edits
    /// </summary>
    procedure AtualizarPosicaoEdits(AComponente: TComponent;
      ATabSheetCadastro: TTabSheet; var lLeft: Integer; var lTop: Integer);
    /// <summary>
    /// Atualiza posicionamento LEFT dos edits criados automáticamente
    /// </summary>
    procedure AtualizarPosicaoLeftEdit(AComponente: TComponent; var lLeft: Integer);
    /// <summary>
    /// Coleta os Frames com subtabelas para controle de informação
    /// </summary>
    procedure ColetarFrames;
  protected
    /// <summary>
    /// Seleciona uma célula no DBgrid para edição
    /// </summary>
    procedure SelecionarCelula(Sender: TObject);
    /// <summary>
    /// Cria um novo registro
    /// </summary>
    function Novo: IBaseCadastro;
    /// <summary>
    /// Habilita a edição de um registro selecionado
    /// </summary>
    function Editar: IBaseCadastro;
    /// <summary>
    /// Deleta um registro selecionado
    /// </summary>
    function Excluir: IBaseCadastro;
    /// <summary>
    /// Grava um registro em edição
    /// </summary>
    function Gravar: IBaseCadastro;
    /// <summary>
    /// Cancela a edição de um registro
    /// </summary>
    function Cancelar: IBaseCadastro;
    /// <summary>
    ///  Varifica se o campo pode ser exibido
    /// </summary>
    /// <param name="AField">
    ///  O campo FIELD é passado como paramentro para ser verificado se tem visibilidade;
    /// </param>
    function ValidarCampoVisivel(
  const AFieldName: String): Boolean;
    /// <summary>
    ///  Cria o controle para os formulários
    /// </summary>
    /// <param name="AEmbedded">
    ///  Injeta a dependencia do Fromulário que fornececera as informações para a automação das ações
    /// </param>
    constructor create(AEmbedded: TForm);
    /// <summary>
    ///  Cria uma lista com os eventos do CRUD
    /// </summary>
    property ListaAcoes: TDicionarioAcoes read FListaAcoes write FListaAcoes;
    /// <summary>
    /// Grava um registro Automaticamento
    /// </summary>
    function GravarAutomatico: IBaseCadastro;
  public
    /// <summary>
    ///  Instancia o controle
    /// </summary>
    /// <param name="AEmbedded">
    ///  Injeta a dependencia do Fromulário que fornececera as informações para a automação das ações
    /// </param>
    class function New(AEmbedded: TForm): IBaseCadastro;
    function IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
    function SetGravaAutomatico(AProcedimento: TRotinaGravaAutomatico):IBaseCadastro;
    function GetGravaAutomatico: TRotinaGravaAutomatico;
    destructor Destroy; override;
  end;

implementation

uses
  Vendas.Dao, Vendas.View.Frame.Base;

resourcestring
  csPREFIXO_CHECKBOX = 'chk%s';
  csPREFIXO_EDIT = 'edt%s';
  csEVENTO_ONEXIT = 'OnExit';

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
  CapturaChavePrimaria;
  GerarEditsAutomatico;
  ColetarMetodoEditAtributos;
  ColetarFrames;
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
//  lField: TField;
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
//        lField := lDataSet.FindField(FPrimariKeyFieldBase.FieldName);
        if (lDataSet.State in dsEditModes) and (not lDataSet.IsEmpty)  then
        begin
          lDataSet.post;
//          lDataSet.First;
//          while not lDataSet.Eof do
//          begin
//            if lField.value <> null then
//            begin
//              lDataSet.Next;
//              Continue;
//            end;
//
//            lDataSet.Edit;
//            lField.Value := FPrimariKeyFieldBase.Value;
//            lDataSet.post;
//            lDataSet.Next;
//          end;
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

function TBaseCadastroController.GravarAutomatico: IBaseCadastro;
begin
  if ( FAcaoAtual = taNovo) then
  begin
    Gravar;
    FAcaoAtual := taEditar;
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

function TBaseCadastroController.SetGravaAutomatico(
  AProcedimento: TRotinaGravaAutomatico): IBaseCadastro;
begin
  Result := Self;
  FGravaAutomaticoProc := AProcedimento;
end;

function TBaseCadastroController.ValidarCampoVisivel(
  const AFieldName: String): Boolean;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo: TRttiType;
  lRTTIAtributo: TCustomAttribute;
begin
  Result := False;
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFormularioBase.ClassType);
  for lRTTIAtributo in lRTTITipo.GetAttributes do
    if lRTTIAtributo is TDesabilitaCamposAtributes then
    begin
      Result := TDesabilitaCamposAtributes(lRTTIAtributo).ValidarCampo(AFieldName);
      Break;
    end;
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

procedure TBaseCadastroController.CapturaChavePrimaria;
var
  lField: TField;
begin
  for lField in FDataSourcePrincipal.DataSet.Fields do
  begin
    if lField.datatype = ftAutoInc then
    begin
      FPrimariKeyFieldBase := lField;
      Exit;
    end;
  end;
end;

procedure TBaseCadastroController.GerarEditsAutomatico;
var
  lField: TField;
  lTabSheetCadastro: TTabSheet;
  lTop, lLeft: Integer;
begin
  if not FGeraEdits then
    Exit;

  lTabSheetCadastro:= FListaTabSheets.Items[csEdicao];
  lTop := lTabSheetCadastro.Top + csPOSICAO_TOP_EDIT;
  lLeft:= lTabSheetCadastro.Left + csPOSICAO_LEFT_EDIT;
  for lField in FDataSourcePrincipal.DataSet.Fields do
  begin
    if ValidarCampoVisivel(lField.FieldName) then
      Continue;

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

function TBaseCadastroController.GetGravaAutomatico: TRotinaGravaAutomatico;
begin
  Result := Gravar;
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
      if ValidarCampoVisivel(lField.FieldName) then
        Continue;

      lColuna := FDBGridListagem.Columns.Add;
      lColuna.Field := lField;
      lColuna.Title.Caption := lField.DisplayLabel;
      lColuna.Width := (lField.DisplayWidth * 2) + 100;
    end;
    FDBGridListagem.OnDblClick:= SelecionarCelula;
  end;
end;

procedure TBaseCadastroController.ColetarFrames;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo, lRTTITipoFrame: TRttiType;
  lRTTIField, lRTTIFieldFrame: TRttiField;
  lFrame: TFrame;
  lDataSource: TDataSource;
  lDataSorceshared: TFDQuery;
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
        lDataSorceshared := (lDataSource.DataSet as TFDQuery);
        lDataSorceshared.MasterSource := FDataSourcePrincipal;
        lDataSorceshared.MasterFields := FPrimariKeyFieldBase.FieldName;
        lDataSorceshared.IndexFieldNames := FPrimariKeyFieldBase.FieldName;
        TframeBase(lFrame).ControllerFrame.SetGravaAutomatico(GravarAutomatico);
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
      if lRTTIAtributo is TEventoOnExitAtributes then
      begin
        lNomeComponent := format(csPREFIXO_EDIT,[TEventoOnExitAtributes(lRTTIAtributo).NomeCampo]);
        if Assigned(FListaTabSheets.Items[csEdicao].FindComponent(lNomeComponent)) then
        begin
          lLabelEditComponente :=  TDBLabeledEdit(FListaTabSheets.Items[csEdicao].FindComponent(lNomeComponent));
          lRTTITipoEdit := lRTTIContexto.GetType(lLabelEditComponente.ClassType);
          lRTTIProperty := lRTTITipoEdit.GetProperty(csEVENTO_ONEXIT);
          lHandlerMetodo.Code := lRTTIMetodo.CodeAddress;
          lHandlerMetodo.Data := lLabelEditComponente;
          lRTTIProperty.SetValue(lLabelEditComponente,TValue.From<TNotifyEvent>(TNotifyEvent(lHandlerMetodo)));          
        end;
        FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;
      end;
end;

end.
