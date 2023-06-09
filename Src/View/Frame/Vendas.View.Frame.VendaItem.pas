unit Vendas.View.Frame.VendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Frame.Base,  Vcl.Graphics,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vendas.Classes.Atributo, Data.DB;

type
  [TDesabilitaCamposAtributes('cdVendaitem')]
  [TDesabilitaCamposAtributes('cdvenda')]
  [TDesabilitaCamposAtributes('flStatus')]
  [TTituloFormAtributes('Detalhamento de Itens',true)]
  TframeVendaItem = class(TframeBase)
  private
    procedure CalcularValorQtdeProduto(Sender: TObject);
  public
    [TEventoOnExitAtributes('cdProduto')]
    procedure VerificarProduto(Sender: TObject);
    [TEventoOnExitAtributes('nuQuantidade')]
    procedure CalcularPreçoProduto(Sender: TObject);
  end;

implementation

uses
  Vendas.Controller.Vendas.Item;

{$R *.dfm}

{ TframeVendaItem }

procedure TframeVendaItem.CalcularPreçoProduto(Sender: TObject);
begin
  CalcularValorQtdeProduto(Sender);
end;

procedure TframeVendaItem.CalcularValorQtdeProduto(Sender: TObject);
begin
  var lVendaItemControle := TVendaItemControle.New(Sender);
  try
    lVendaItemControle.CalcularValorQtdeProduto;
  finally
    lVendaItemControle.Free;
  end;
end;

procedure TframeVendaItem.VerificarProduto(Sender: TObject);
begin
  var lVendaItemControle := TVendaItemControle.New(Sender);
  try
    lVendaItemControle
      .VerificarProdutoExist;
  finally
    lVendaItemControle.free;
  end;
end;


end.
