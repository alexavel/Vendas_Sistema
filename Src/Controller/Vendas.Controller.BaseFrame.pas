unit Vendas.Controller.BaseFrame;

interface

uses
  Vendas.Interfaces.BaseCadastro, Vcl.Forms, System.Classes, Vcl.ActnList, Generics.Collections,
  Vcl.ComCtrls, RTTI, Vendas.Classes.Atributo, Data.DB, System.SysUtils, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, Vcl.Dialogs;
const
  csPOSICAO_LEFT_EDIT = 20;
  csPOSICAO_TOP_EDIT = 25;
  csMARGIN_TOP_EDIT = 30;

Type
  TBaseFrameController = class(TInterfacedObject, IBaseCadastro)
  private
    FFrameBase: TFrame;
    FListaAcoesFrame: TDicionarioAcoes;
    FListaTabSheetsFrame: TDicionarioTabSheets;
    FPageBaseFrame: TPageControl;
    FAcaoAtualFrame: TTipoAcao;
    FDataSourceFrame: TDataSource;
    FDBGridListagemFrame: TDBGrid;
    FGeraEdits: Boolean;
    procedure ColetarAtributos;
    procedure ColetarMetodoEditAtributos;
    procedure HabilitarBotoes;
    procedure SelecionarPagina;
    procedure ConfigurarBasePrincipal(ADataSource: TDataSource);
    procedure ConfigurarPaginaCadastro(lRTTIField: TRttiField);
    procedure ConfigurarGrid(lRTTIField: TRttiField);
    procedure ConfiguraAtibutos(lRTTIField: TRttiField);
    procedure GerarEditsAutomatico;
    procedure ConstruirEdit(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
    procedure ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
    procedure AtualizarPosicaoEdits(AComponente: TComponent; ATabSheetCadastro: TTabSheet; var ALeft: Integer; var ATop: Integer);
    procedure AtualizarPosicaoLeftEdit(AComponente: TComponent; var ALeft: Integer);
  protected
    procedure SelecionarCelula(Sender: TObject);
    property ListaAcoes: TDicionarioAcoes read FListaAcoesFrame write FListaAcoesFrame;

  public
    constructor create(AEmbedded: TFrame);
    destructor Destroy; override;
    class function New(AEmbedded: TFrame): IBaseCadastro;

    function IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
    function Novo: IBaseCadastro;
    function Editar: IBaseCadastro;
    function Excluir: IBaseCadastro;
    function Gravar: IBaseCadastro;
    function Cancelar: IBaseCadastro;
  end;

implementation

resourcestring
  csPREFIXO_CHECKBOX = 'chk%s';
  csPREFIXO_EDIT = 'edt%s';

{ TBaseCadstro }

constructor TBaseFrameController.create(AEmbedded: TFrame);
begin
  FFrameBase := AEmbedded;
  FListaAcoesFrame:= TDicionarioAcoes.Create;
  FListaTabSheetsFrame:= TDicionarioTabSheets.Create;
  ColetarAtributos;
  FAcaoAtualFrame := taBrowse;
  HabilitarBotoes;
  GerarEditsAutomatico;
  ColetarMetodoEditAtributos;
end;

destructor TBaseFrameController.Destroy;
begin
  if Assigned(FListaAcoesFrame) then
    FListaAcoesFrame.Free;

  if Assigned(FListaTabSheetsFrame) then
    FListaTabSheetsFrame.Free;
  inherited;
end;

function TBaseFrameController.Novo: IBaseCadastro;
begin
  FDataSourceFrame.DataSet.Append;
end;

function TBaseFrameController.Editar: IBaseCadastro;
begin
  FDataSourceFrame.DataSet.Edit;
end;

function TBaseFrameController.Excluir: IBaseCadastro;
begin
  FDataSourceFrame.DataSet.Delete;
end;

function TBaseFrameController.Gravar: IBaseCadastro;
begin
  //
end;

function TBaseFrameController.Cancelar: IBaseCadastro;
begin
  FDataSourceFrame.DataSet.Cancel;
end;

procedure TBaseFrameController.HabilitarBotoes;
begin
  FListaAcoesFrame.Items[taNovo].Enabled    := ( FAcaoAtualFrame in csModEdicao);
  FListaAcoesFrame.Items[taEditar].Enabled  := ( FAcaoAtualFrame in csModEdicao) and (FDataSourceFrame.DataSet.RecordCount > 0);
  FListaAcoesFrame.Items[taExcluir].Enabled := ( FAcaoAtualFrame in csModEdicao) and (FDataSourceFrame.DataSet.RecordCount > 0);
  FListaAcoesFrame.Items[taGravar].Enabled  := ( FAcaoAtualFrame in csModPersisten);
  FListaAcoesFrame.Items[taCancelar].Enabled:= ( FAcaoAtualFrame in csModPersisten);
  SelecionarPagina;
end;

procedure TBaseFrameController.SelecionarCelula(Sender: TObject);
begin
  if FDataSourceFrame.DataSet.IsEmpty then
    Exit;

  IniciarAcao(taEditar);
end;

procedure TBaseFrameController.SelecionarPagina;
begin
  if FAcaoAtualFrame in csVizualizacao then
    FPageBaseFrame.ActivePage :=  FListaTabSheetsFrame.Items[csVizualizacao]
  else
    FPageBaseFrame.ActivePage :=  FListaTabSheetsFrame.Items[csEdicao];
end;

function TBaseFrameController.IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
begin
  result := Self;
  FAcaoAtualFrame := AAcao;
  HabilitarBotoes;
  case AAcao of
    taNovo: Novo;
    taEditar: Editar;
    taExcluir: Excluir;
    taGravar: Gravar;
    taCancelar: Cancelar;
  end;
end;

procedure TBaseFrameController.GerarEditsAutomatico;
var
  lField: TField;
  lTabSheetCadastro: TTabSheet;
  lTop, lLeft: Integer;
begin
  if not FGeraEdits then
    Exit;

  lTabSheetCadastro:= FListaTabSheetsFrame.Items[csEdicao];
  lTop := csPOSICAO_TOP_EDIT;
  lLeft:= csPOSICAO_LEFT_EDIT;
  for lField in FDataSourceFrame.DataSet.Fields do
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

procedure TBaseFrameController.ConstruirEdit(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lLabelEdit: TDBLabeledEdit;
begin
  lLabelEdit := TDBLabeledEdit.Create(ATabSheetCadastro);
  lLabelEdit.Parent := ATabSheetCadastro;
  lLabelEdit.AlignWithMargins := True;
  lLabelEdit.Name := Format(csPREFIXO_EDIT,[lField.FieldName]);
  lLabelEdit.DataSource := FDataSourceFrame;
  lLabelEdit.DataField := lField.FieldName;
  lLabelEdit.EditLabel.Caption := lField.DisplayLabel;
  lLabelEdit.Width := (lField.DisplayWidth * 2) + 100;
  AtualizarPosicaoEdits(lLabelEdit, ATabSheetCadastro, lLeft, lTop);
  lLabelEdit.Top := lTop;
  lLabelEdit.Left := lLeft;
  lLabelEdit.AlignWithMargins := True;
  lLabelEdit.Margins.Top := csMARGIN_TOP_EDIT;
  lLabelEdit.Enabled := not lField.ReadOnly;
  lLabelEdit.MaxLength := lField.DisplayWidth;
  AtualizarPosicaoLeftEdit(lLabelEdit, lLeft);
end;

procedure TBaseFrameController.ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lCheckBox: TDBCheckBox;
begin
  lCheckBox := TDBCheckBox.Create(ATabSheetCadastro);
  lCheckBox.Parent := ATabSheetCadastro;
  lCheckBox.AlignWithMargins := True;
  lCheckBox.Name := Format(csPREFIXO_CHECKBOX,[lField.FieldName]);
  lCheckBox.DataSource := FDataSourceFrame;
  lCheckBox.DataField := lField.FieldName;
  lCheckBox.Caption := lField.DisplayLabel;
  lCheckBox.Width := (lField.DisplayWidth * 2) + 100;
  AtualizarPosicaoEdits(lCheckBox, ATabSheetCadastro, lLeft, lTop);
  lCheckBox.Top := lTop;
  lCheckBox.Left := lLeft;
  lCheckBox.AlignWithMargins := True;
  lCheckBox.Margins.Top := csMARGIN_TOP_EDIT;
  lCheckBox.Margins.Left := csPOSICAO_LEFT_EDIT;
  lCheckBox.Enabled := not lField.ReadOnly;
  AtualizarPosicaoLeftEdit(lCheckBox, lLeft);
end;

procedure TBaseFrameController.AtualizarPosicaoLeftEdit(AComponente: TComponent; var ALeft: Integer);
begin
  ALeft := ALeft + TControl(AComponente).Width + csPOSICAO_LEFT_EDIT;
end;

procedure TBaseFrameController.AtualizarPosicaoEdits(AComponente: TComponent; ATabSheetCadastro: TTabSheet; var ALeft: Integer; var ATop: Integer);
begin
  var lEspacoLinhaAtual := ((ATabSheetCadastro.Width + csPOSICAO_LEFT_EDIT) - ALeft);
  var lTamanhoEdit := TControl(AComponente).Width;
  if lTamanhoEdit > lEspacoLinhaAtual then
  begin
    ATop := ATop + (csPOSICAO_TOP_EDIT * 2);
    ALeft := csPOSICAO_LEFT_EDIT;
  end;
end;

procedure TBaseFrameController.ConfigurarPaginaCadastro(lRTTIField: TRttiField);
begin
  if lRTTIField.GetValue(FFrameBase).IsObject and
     (lRTTIField.GetValue(FFrameBase).AsObject is TPageControl) then
    FPageBaseFrame := TPageControl(lRTTIField.GetValue(FFrameBase).AsObject);
end;

procedure TBaseFrameController.ConfiguraAtibutos(lRTTIField: TRttiField);
var
  lRTTIAtributo: TCustomAttribute;
  lAction: TAction;
  lTabSheet: TTabSheet;
begin
  for lRTTIAtributo in lRTTIField.GetAttributes do
  begin
    if lRTTIAtributo is TAcoesAtributes then
    begin
      lAction := TAction(lRTTIField.GetValue(FFrameBase).AsObject);
      FListaAcoesFrame.Add(TAcoesAtributes(lRTTIAtributo).TipoAcao, lAction);
    end else if lRTTIAtributo is TOperacaoAtributes then
    begin
      lTabSheet := TTabSheet(lRTTIField.GetValue(FFrameBase).AsObject);
      FListaTabSheetsFrame.Add(TOperacaoAtributes(lRTTIAtributo).TipoOperacao, lTabSheet);
    end;
  end;
end;

procedure TBaseFrameController.ConfigurarBasePrincipal(ADataSource: TDataSource);
begin
  FDataSourceFrame := ADataSource;
  if not Assigned(FDataSourceFrame.DataSet) then
    raise Exception.Create('Erro: Base de dados não configurada.');

  FDataSourceFrame.DataSet.Active := True;
end;

procedure TBaseFrameController.ConfigurarGrid(lRTTIField: TRttiField);
var
  lField: TField;
  lColuna: TColumn;
begin
  if lRTTIField.GetValue(FFrameBase).IsObject and
     (lRTTIField.GetValue(FFrameBase).AsObject is TDBGrid) then
  begin
    FDBGridListagemFrame := TDBGrid(lRTTIField.GetValue(FFrameBase).AsObject);
    if not Assigned(FDBGridListagemFrame.DataSource) then
      raise Exception.Create('Erro: Base de dados não configurada.');

    ConfigurarBasePrincipal(FDBGridListagemFrame.DataSource);
    for lField in FDataSourceFrame.DataSet.Fields do
    begin
      lColuna := FDBGridListagemFrame.Columns.Add;
      lColuna.Field := lField;
      lColuna.Title.Caption := lField.DisplayLabel;
      lColuna.Width := (lField.DisplayWidth * 2) + 100;
    end;
  FDBGridListagemFrame.OnDblClick:= SelecionarCelula;
  end;
end;

procedure TBaseFrameController.ColetarAtributos;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo: TRttiType;
  lRTTIField: TRttiField;
  lRTTIAtributo: TCustomAttribute;
begin
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFrameBase.ClassType);
  for lRTTIAtributo in lRTTITipo.GetAttributes do
    if lRTTIAtributo is TTituloFormAtributes then
    begin
       //AtribuirCaptionForm(TTituloFormAtributes(lRTTIAtributo).CaptionForm);
       FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;
    end;

  for lRTTIField in lRTTITipo.GetFields do
  begin
    ConfigurarPaginaCadastro(lRTTIField);
    ConfigurarGrid(lRTTIField);
    ConfiguraAtibutos(lRTTIField);
  end;
end;

procedure TBaseFrameController.ColetarMetodoEditAtributos;
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
  lRTTITipo := lRTTIContexto.GetType(FFrameBase.ClassType);
  for lRTTIMetodo in lRTTITipo.GetMethods do
    for lRTTIAtributo in lRTTIMetodo.GetAttributes do
      if lRTTIAtributo is TValidaCamposAtributes then
      begin
        lNomeComponent := format(csPREFIXO_EDIT,[TValidaCamposAtributes(lRTTIAtributo).NomeCampo]);
        if Assigned(FListaTabSheetsFrame.Items[csEdicao].FindComponent(lNomeComponent)) then
        begin
          lLabelEditComponente :=  TDBLabeledEdit(FListaTabSheetsFrame.Items[csEdicao].FindComponent(lNomeComponent));
          lRTTITipoEdit := lRTTIContexto.GetType(lLabelEditComponente.ClassType);
          lRTTIProperty := lRTTITipoEdit.GetProperty('OnExit');
          lHandlerMetodo.Code := lRTTIMetodo.CodeAddress;
          lHandlerMetodo.Data := lLabelEditComponente;
          lRTTIProperty.SetValue(lLabelEditComponente,TValue.From<TNotifyEvent>(TNotifyEvent(lHandlerMetodo)));
        end;

        FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;
      end;
end;

class function TBaseFrameController.New(AEmbedded: TFrame): IBaseCadastro;
begin
  Result := Self.Create(AEmbedded)
end;

end.
