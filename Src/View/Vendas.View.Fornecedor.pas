unit Vendas.View.Fornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vendas.Dao, Vendas.Classes.Atributo;

type
  [TTituloFormAtributes('Cadastro de Fornecedores',true)]
  TfrmFornecedor = class(TfrmBaseCadastro)
  public
    [TValidaCamposAtributes('nucnpj')]
    procedure VerificarCNPJ(Sender: TObject);
  end;

implementation

uses
  Vendas.Controller.Fornecedor;

{$R *.dfm}

{ TfrmCliente }

procedure TfrmFornecedor.VerificarCNPJ(Sender: TObject);
begin
  TFornecedorController.New(Sender).ValidarCNPJ;
end;

end.
