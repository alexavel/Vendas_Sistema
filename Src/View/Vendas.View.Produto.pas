unit Vendas.View.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vendas.Dao, Vendas.Classes.Atributo;

type
  [TTituloFormAtributes('Cadastro de Produtos',true)]
  TfrmProduto = class(TfrmBaseCadastro)
  public
    [TValidaCamposAtributes('cdfornecedor')]
    procedure VerificarExisteFornecedor(Sender: TObject);
    [TValidaCamposAtributes('vlUnitario')]
    procedure VerificarPrecoZerado(Sender: TObject);
  end;

implementation

uses
  Vendas.Controller.Produto;

{$R *.dfm}

{ TfrmProduto }

procedure TfrmProduto.VerificarExisteFornecedor(Sender: TObject);
begin
  TProdutoController.New(Sender).validarFornecedor;
end;

procedure TfrmProduto.VerificarPrecoZerado(Sender: TObject);
begin
  TProdutoController.New(Sender).validarPreco;
end;

end.
