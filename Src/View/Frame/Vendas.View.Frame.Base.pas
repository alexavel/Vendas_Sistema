unit Vendas.View.Frame.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, Vcl.ComCtrls,
  Vendas.Interfaces.BaseCadastro, Vendas.Controller.BaseFrame, Vendas.Classes.Atributo,
  Vendas.Dao;

type
  TRotinaExterna = procedure(Sender: TObject) of object;
  [TTituloFormAtributes('Detalhamento de Itens',true)]
  TframeBase = class(TFrame)
    pnlCenter: TPanel;
    pnlSide: TPanel;
    btnNew: TButton;
    btnEdit: TButton;
    btnDel: TButton;
    actFrameAcoes: TActionList;
    [TAcoesAtributes(taNovo)]
    actNew: TAction;
    [TAcoesAtributes(taEditar)]
    actEdit: TAction;
    [TAcoesAtributes(taExcluir)]
    actDel: TAction;
    dsBaseChild: TDataSource;
    btnCan: TButton;
    [TAcoesAtributes(taCancelar)]
    actCan: TAction;
    pgChildBase: TPageControl;
    [TOperacaoAtributes(csVizualizacao)]
    tbsChildListagem: TTabSheet;
    [TOperacaoAtributes(csEdicao)]
    tbsChildCadastro: TTabSheet;
    dbgFrame: TDBGrid;
    btnSaf: TButton;
    [TAcoesAtributes(taGravar)]
    actSaf: TAction;
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actCanExecute(Sender: TObject);
    procedure actSafExecute(Sender: TObject);
  private
    FControllerFrame: IBaseCadastro;
    FRotinaExterna: TRotinaExterna;
    FGravarAutomatico: TRotinaGravaAutomatico;
    procedure ConfigurarTela;
  public
    constructor Create(AOwner: TComponent); override;

    property RotinaExterna: TRotinaExterna read FRotinaExterna write FRotinaExterna;
    property GravarAutomatico: TRotinaGravaAutomatico read FGravarAutomatico write FGravarAutomatico;
    property ControllerFrame: IBaseCadastro read FControllerFrame write FControllerFrame;
  end;

implementation

{$R *.dfm}

{ TframeBase }

procedure TframeBase.actCanExecute(Sender: TObject);
begin
  FControllerFrame.IniciarAcao(taCancelar)
end;

procedure TframeBase.actDelExecute(Sender: TObject);
begin
  FControllerFrame.IniciarAcao(taExcluir)
end;

procedure TframeBase.actEditExecute(Sender: TObject);
begin
  FControllerFrame.IniciarAcao(taEditar)
end;

procedure TframeBase.actNewExecute(Sender: TObject);
begin
  FControllerFrame.IniciarAcao(taNovo)
end;

procedure TframeBase.actSafExecute(Sender: TObject);
begin
  FControllerFrame.IniciarAcao(taGravar)
end;

constructor TframeBase.Create(AOwner: TComponent);
begin
  inherited;
  FControllerFrame:= TBaseFrameController.New(Self);
  ConfigurarTela;
end;

procedure TframeBase.ConfigurarTela;
begin
  Self.pgChildBase.Pages[0].TabVisible := False;
  Self.pgChildBase.Pages[1].TabVisible := False;
  FControllerFrame.IniciarAcao(taBrowse);
end;

end.
