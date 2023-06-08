unit Vendas.View.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vendas.Dao, Vendas.Classes.Atributo;

type
  [TTituloFormAtributes('Cadastro de Clientes',true)]
  TfrmCliente = class(TfrmBaseCadastro)
  public
    [TEventoOnExitAtributes('nucpf')]
    procedure VerificarCPF(Sender: TObject);
  end;

implementation

uses
  Vendas.Controller.Cliente;

{$R *.dfm}

{ TfrmCliente }

procedure TfrmCliente.VerificarCPF(Sender: TObject);
begin
  var lControleCliente := TClienteController.New(Sender);
  try
    lControleCliente.ValidarCPF;
  finally
    lControleCliente.Free;
  end;
end;

end.
