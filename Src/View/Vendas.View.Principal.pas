unit Vendas.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrmMain = class(TForm)
    mnMain: TMainMenu;
    V1: TMenuItem;
    Cliente1: TMenuItem;
    Fornecedores1: TMenuItem;
    Fornecedores2: TMenuItem;
    Movimentaes1: TMenuItem;
    Vendas1: TMenuItem;
    actMain: TActionList;
    actCliente: TAction;
    actFornecedor: TAction;
    actProduto: TAction;
    actVenda: TAction;
    Relatrios1: TMenuItem;
    ListagemdeClientes1: TMenuItem;
    actReportCliente: TAction;
    actReportVenda: TAction;
    actReportVenda1: TMenuItem;
    procedure actClienteExecute(Sender: TObject);
    procedure actFornecedorExecute(Sender: TObject);
    procedure actProdutoExecute(Sender: TObject);
    procedure actVendaExecute(Sender: TObject);
    procedure actReportClienteExecute(Sender: TObject);
    procedure actReportVendaExecute(Sender: TObject);
  private
    procedure AbrirFormulario(AFrm: TFormClass);
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Vendas.View.Cliente, Vendas.View.Fornecedor, Vendas.View.Produto, Vendas.View.Venda,
  Vendas.View.Report.Cliente, Vendas.View.Report.Venda;

{$R *.dfm}

procedure TfrmMain.AbrirFormulario(AFrm: TFormClass);
var
  lfrmAtivo: TForm;
begin
  lfrmAtivo:= AFrm.Create(Self);
  try
    lfrmAtivo.ShowModal;
  finally
    lfrmAtivo.Free
  end;
end;

procedure TfrmMain.actClienteExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmCliente);
end;

procedure TfrmMain.actFornecedorExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmFornecedor);
end;

procedure TfrmMain.actProdutoExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmProduto);
end;

procedure TfrmMain.actReportClienteExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmReportCliente);
end;

procedure TfrmMain.actReportVendaExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmReportVenda);
end;

procedure TfrmMain.actVendaExecute(Sender: TObject);
begin
  AbrirFormulario(TfrmVenda);
end;

end.
