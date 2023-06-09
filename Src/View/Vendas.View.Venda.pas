unit Vendas.View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vendas.Dao, Vendas.Classes.Atributo, Vcl.Mask,
  Vcl.DBCtrls, Vendas.View.Frame.Base,  Vendas.View.Frame.VendaItem, FireDAC.Comp.Client;

type
  [TTituloFormAtributes('Tela de Vendas', true)]
  TfrmVenda = class(TfrmBaseCadastro)
    frameVendaItem: TframeVendaItem;
    procedure FormCreate(Sender: TObject);
  public
    [TEventoOnExitAtributes('cdCliente')]
    procedure VerificarCliente(Sender: TObject);
  end;

implementation

uses
  Vendas.Controller.Vendas;

{$R *.dfm}

{ TfrmVenda }

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  inherited;
  frameVendaItem.GravarAutomatico := GetGravarAutomatico;
end;

procedure TfrmVenda.VerificarCliente(Sender: TObject);
begin
  var lVendaControle := TVendaController.New(Sender);
  try
    lVendaControle.ValidarCliente;
  finally
    lVendaControle.Free;
  end;
end;

end.
