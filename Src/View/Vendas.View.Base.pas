unit Vendas.View.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vendas.Interfaces.BaseCadastro, Vendas.Controller.BaseCadastro, Vendas.Classes.Atributo,
  Vendas.Dao;

type
  [TTituloFormAtributes('Cadastro Base',true)]
  TfrmBaseCadastro = class(TForm)
    pgBaseCadasro: TPageControl;
    [TOperacaoAtributes(csVizualizacao)]
    tbsListagem: TTabSheet;
    [TOperacaoAtributes(csEdicao)]
    tbsFormulario: TTabSheet;
    pnlSide: TPanel;
    btnCancelar: TButton;
    actBaseFormulario: TActionList;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnGravar: TButton;
    btnSair: TButton;
    [TAcoesAtributes(taNovo)]
    actNovo: TAction;
    [TAcoesAtributes(taEditar)]
    actAlterar: TAction;
    [TAcoesAtributes(taExcluir)]
    actExcluir: TAction;
    [TAcoesAtributes(taGravar)]
    actGravar: TAction;
    [TAcoesAtributes(taCancelar)]
    actCancelar: TAction;
    actSair: TAction;
    hitBalao: TBalloonHint;
    dbgListagem: TDBGrid;
    dsBase: TDataSource;
    gpbDetalhes: TGroupBox;
    stbFooter: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FBaseCadastro: IBaseCadastro;
    procedure ConfigurarTela;
  public
  end;

implementation

{$R *.dfm}

{ TfrmBaseCadastro }

procedure TfrmBaseCadastro.actAlterarExecute(Sender: TObject);
begin
  FBaseCadastro.IniciarAcao(taEditar)
end;

procedure TfrmBaseCadastro.actCancelarExecute(Sender: TObject);
begin
  FBaseCadastro.IniciarAcao(taCancelar);
end;

procedure TfrmBaseCadastro.actExcluirExecute(Sender: TObject);
begin
  FBaseCadastro.IniciarAcao(taExcluir);
end;

procedure TfrmBaseCadastro.actGravarExecute(Sender: TObject);
begin
  FBaseCadastro.IniciarAcao(taGravar);
end;

procedure TfrmBaseCadastro.actNovoExecute(Sender: TObject);
begin
  FBaseCadastro.IniciarAcao(taNovo);
end;

procedure TfrmBaseCadastro.actSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaseCadastro.ConfigurarTela;
begin
  Self.pgBaseCadasro.Pages[0].TabVisible := False;
  Self.pgBaseCadasro.Pages[1].TabVisible := False;
end;

procedure TfrmBaseCadastro.FormCreate(Sender: TObject);
begin
  FBaseCadastro := TBaseCadastroController.New(Self);
  ConfigurarTela;
end;

procedure TfrmBaseCadastro.FormShow(Sender: TObject);
begin
  FBaseCadastro
    .IniciarAcao(taBrowse);
end;

end.
