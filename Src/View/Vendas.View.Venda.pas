unit Vendas.View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vendas.Dao, Vendas.Classes.Atributo, Vcl.Mask,
  Vcl.DBCtrls, Vendas.View.Frame.Base, Vendas.Controller.Vendas;

type
  [TTituloFormAtributes('Tela de Vendas', true)]
  TfrmVenda = class(TfrmBaseCadastro)
    frameBaseTeste: TframeBase;
  public
//    [TValidaCamposAtributes('cd')]
//    procedure VerificarCPF(Sender: TObject);
  end;

implementation

{$R *.dfm}

end.
