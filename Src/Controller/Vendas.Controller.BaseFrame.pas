unit Vendas.Controller.BaseFrame;

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
  TBaseFrameController = class(TInterfacedObject, IBaseCadastro)
  private
    FFrameBase: TFrame;
    FListaAcoesFrame: TDicionarioAcoes;
    FListaTabSheetsFrame: TDicionarioTabSheets;
    FListaDataFramesFrame: TDicionarioDataSourceFrame;
    FPageBaseCadasroFrame: TPageControl;
    FAcaoAtual: TTipoAcao;
    FDataSourceFrame: TDataSource;
    FDBGridListagemFrame: TDBGrid;
    FGeraEdits: Boolean;
    FPrimariKeyFieldBase: TField;
    /// <summary>
    /// Faz coleta dos atributos associados ao FRAME
    /// </summary>
    procedure ColetarAtributos;
    /// <summary>
    /// Faz coleta dos métodos para atribuir a eventos dos componentes edit como: OnExit, OnEnter...
    /// </summary>
    procedure ColetarMetodoEditAtributos;
    /// <summary>
    /// Faz o controle de botões de edição do FRAME
    /// </summary>
    procedure HabilitarBotoes;
    /// <summary>
    /// Seleciona página de trabalho conforme ação chamada
    /// </summary>
    procedure SelecionarPagina;
    /// <summary>
    /// Configura o controle da base de dados principal do FRAME
    /// </summary>
    procedure ConfigurarBasePrincipal(ADataSource: TDataSource);
    /// <summary>
    /// Configura o controle do TPageControl do FRAME
    /// </summary>
    procedure ConfigurarPaginaCadastro(lRTTIField: TRttiField);
    /// <summary>
    /// Faz a configuração e controle do DBGrid principal da listagem
    /// </summary>
    procedure ConfigurarGrid(lRTTIField: TRttiField);
    /// <summary>
    /// Configura as ações e opreações do FRAME pelo atributo
    /// </summary>
    procedure ConfiguraAtibutos(lRTTIField: TRttiField);
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
    constructor create(AEmbedded: TFrame);
    /// <summary>
    ///  Cria uma lista com os eventos do FRAME
    /// </summary>
    property ListaAcoes: TDicionarioAcoes read FListaAcoesFrame write FListaAcoesFrame;
  public
    /// <summary>
    ///  Instancia o controle
    /// </summary>
    /// <param name="AEmbedded">
    ///  Injeta a dependencia do Fromulário que fornececera as informações para a automação das ações
    /// </param>
    class function New(AEmbedded: TFrame): IBaseCadastro;
    function IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
    destructor Destroy; override;
  end;

implementation

uses
  Vendas.Dao;

resourcestring
  csPREFIXO_CHECKBOX = 'chk%s';
  csPREFIXO_EDIT = 'edt%s';
  csEVENTO_ONEXIT = 'OnExit';

{ TBaseCadstro }

class function TBaseFrameController.New(AEmbedded: TFrame): IBaseCadastro;
begin
  Result := Self.Create(AEmbedded)
end;

constructor TBaseFrameController.create(AEmbedded: TFrame);
begin
  FFrameBase := AEmbedded;
  FListaAcoesFrame:= TDicionarioAcoes.Create;
  FListaTabSheetsFrame:= TDicionarioTabSheets.Create;
  FListaDataFramesFrame:= TDicionarioDataSourceFrame.Create;
  ColetarAtributos;
  FAcaoAtual := taBrowse;
  HabilitarBotoes;
  CapturaChavePrimaria;
  GerarEditsAutomatico;
  ColetarMetodoEditAtributos;
  ColetarFrames;
end;

destructor TBaseFrameController.Destroy;
begin
  if Assigned(FListaAcoesFrame) then
    FListaAcoesFrame.Free;

  if Assigned(FListaTabSheetsFrame) then
    FListaTabSheetsFrame.Free;

  if Assigned(FListaDataFramesFrame) then
    FListaDataFramesFrame.Free;

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
  //FDBGridListagemFrame.DataSource.DataSet.EnableControls;
end;

function TBaseFrameController.Cancelar: IBaseCadastro;
begin
  FDataSourceFrame.DataSet.Cancel;
end;

procedure TBaseFrameController.AtualizarPosicaoLeftEdit(AComponente: TComponent; var lLeft: Integer);
begin
  lLeft := lLeft + TControl(AComponente).Width + csPOSICAO_LEFT_EDIT;
end;

procedure TBaseFrameController.AtualizarPosicaoEdits(AComponente: TComponent;
      ATabSheetCadastro: TTabSheet; var lLeft: Integer; var lTop: Integer);
begin
  if ATabSheetCadastro.Width < (lLeft + TControl(AComponente).Width) then
  begin
    lLeft := ATabSheetCadastro.Left + csPOSICAO_LEFT_EDIT;
    lTop := lTop + (csPOSICAO_TOP_EDIT * 2);
  end;
end;

procedure TBaseFrameController.HabilitarBotoes;
begin
  FListaAcoesFrame.Items[taNovo].Enabled    := ( FAcaoAtual in csModEdicao);
  FListaAcoesFrame.Items[taEditar].Enabled  := ( FAcaoAtual in csModEdicao) and (FDataSourceFrame.DataSet.RecordCount > 0);
  FListaAcoesFrame.Items[taExcluir].Enabled := ( FAcaoAtual in csModEdicao) and (FDataSourceFrame.DataSet.RecordCount > 0);
  FListaAcoesFrame.Items[taGravar].Enabled  := ( FAcaoAtual in csModPersisten);
  FListaAcoesFrame.Items[taCancelar].Enabled:= ( FAcaoAtual in csModPersisten);
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
  if FAcaoAtual in csVizualizacao then
    FPageBaseCadasroFrame.ActivePage :=  FListaTabSheetsFrame.Items[csVizualizacao]
  else
    FPageBaseCadasroFrame.ActivePage :=  FListaTabSheetsFrame.Items[csEdicao];
end;

function TBaseFrameController.ValidarCampoVisivel(
  const AFieldName: String): Boolean;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo: TRttiType;
  lRTTIAtributo: TCustomAttribute;
begin
  Result := False;
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFrameBase.ClassType);
  for lRTTIAtributo in lRTTITipo.GetAttributes do
    if lRTTIAtributo is TDesabilitaCamposAtributes then
      if TDesabilitaCamposAtributes(lRTTIAtributo).ValidarCampo(AFieldName) then
        exit(true);
end;

function TBaseFrameController.IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
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

procedure TBaseFrameController.CapturaChavePrimaria;
var
  lField: TField;
begin
  for lField in FDataSourceFrame.DataSet.Fields do
  begin
    if lField.datatype = ftAutoInc then
    begin
      FPrimariKeyFieldBase := lField;
      Exit;
    end;
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
  lTop := lTabSheetCadastro.Top + csPOSICAO_TOP_EDIT;
  lLeft:= lTabSheetCadastro.Left + csPOSICAO_LEFT_EDIT;
  for lField in FDataSourceFrame.DataSet.Fields do
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

procedure TBaseFrameController.ConstruirEdit(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lLabelEdit: TDBLabeledEdit;
begin
  lLabelEdit := TDBLabeledEdit.Create(ATabSheetCadastro);
  lLabelEdit.Parent := ATabSheetCadastro;
  lLabelEdit.Name := Format(csPREFIXO_EDIT,[lField.FieldName]);
  lLabelEdit.DataSource := FDataSourceFrame;
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

procedure TBaseFrameController.ConstruirCheckBox(ATabSheetCadastro: TTabSheet;
  lField: TField; var lTop, lLeft: Integer);
var
  lCheckBox: TDBCheckBox;
begin
  lCheckBox := TDBCheckBox.Create(ATabSheetCadastro);
  lCheckBox.Parent := ATabSheetCadastro;
  lCheckBox.Name := Format(csPREFIXO_CHECKBOX,[lField.FieldName]);
  lCheckBox.DataSource := FDataSourceFrame;
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

procedure TBaseFrameController.ConfigurarPaginaCadastro(lRTTIField: TRttiField);
begin
  if lRTTIField.GetValue(FFrameBase).IsObject and
     (lRTTIField.GetValue(FFrameBase).AsObject is TPageControl) then
    FPageBaseCadasroFrame := TPageControl(lRTTIField.GetValue(FFrameBase).AsObject);
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
      if ValidarCampoVisivel(lField.FieldName) then
        Continue;

      lColuna := FDBGridListagemFrame.Columns.Add;
      lColuna.Field := lField;
      lColuna.Title.Caption := lField.DisplayLabel;
      lColuna.Width := (lField.DisplayWidth * 2) + 100;
    end;
    FDBGridListagemFrame.OnDblClick:= SelecionarCelula;
  end;
end;

procedure TBaseFrameController.ColetarFrames;
var
  lRTTIContexto: TRttiContext;
  lRTTITipo, lRTTITipoFrame: TRttiType;
  lRTTIField, lRTTIFieldFrame: TRttiField;
  lFrame: TFrame;
  lDataSource: TDataSource;
begin
  lDataSource := nil;
  lRTTIContexto:= TRttiContext.Create;
  lRTTITipo := lRTTIContexto.GetType(FFrameBase.ClassType);
  for lRTTIField in lRTTITipo.GetFields do
    if lRTTIField.GetValue(FFrameBase).IsObject and
       (lRTTIField.GetValue(FFrameBase).AsObject is TFrame) then
    begin
      lFrame:= TFrame(lRTTIField.GetValue(FFrameBase).AsObject);
      lRTTITipoFrame := lRTTIContexto.GetType(lFrame.ClassType);
      for lRTTIFieldFrame in lRTTITipoFrame.GetFields do
        if lRTTIFieldFrame.GetValue(lFrame).IsObject and
          (lRTTIFieldFrame.GetValue(lFrame).AsObject is TDataSource) then
        begin
          lDataSource:= TDataSource(lRTTIFieldFrame.GetValue(lFrame).AsObject);
          break
        end;
        FListaDataFramesFrame.Add(lFrame,lDataSource)
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
       FGeraEdits := TTituloFormAtributes(lRTTIAtributo).GeraEdits;

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
      if lRTTIAtributo is TEventoOnExitAtributes then
      begin
        lNomeComponent := format(csPREFIXO_EDIT,[TEventoOnExitAtributes(lRTTIAtributo).NomeCampo]);
        if Assigned(FListaTabSheetsFrame.Items[csEdicao].FindComponent(lNomeComponent)) then
        begin
          lLabelEditComponente :=  TDBLabeledEdit(FListaTabSheetsFrame.Items[csEdicao].FindComponent(lNomeComponent));
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
