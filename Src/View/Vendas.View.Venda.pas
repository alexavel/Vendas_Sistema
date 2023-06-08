unit Vendas.View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vendas.Dao, Vendas.Classes.Atributo, Vcl.Mask,
  Vcl.DBCtrls, Vendas.View.Frame.Base, Vendas.Controller.Vendas,
  Vendas.View.Frame.VendaItem, FireDAC.Comp.Client;

type
  [TTituloFormAtributes('Tela de Vendas', true)]
  TfrmVenda = class(TfrmBaseCadastro)
    frameVendaItem: TframeVendaItem;
  public
    [TEventoOnExitAtributes('cdCliente')]
    procedure VerificarCliente(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TfrmVenda }

procedure TfrmVenda.VerificarCliente(Sender: TObject);
var
  lQueryStr, lResultStr: string;
  lEditCdCliente: TDBEdit;
  lFieldNomeCliente: TDBEdit;
begin
  lEditCdCliente := TDBEdit(Sender);

  if lEditCdCliente.Text = EmptyStr then
    Exit;

  lQueryStr  := 'SELECT deNomeCliente FROM CLIENTE WHERE cdCliente = :cdCliente and flStatus = true';
  lResultStr := dmVendas
                  .fdConetor
                  .ExecSQLScalar(lQueryStr,[StrToInt(lEditCdCliente.Text)]);
  if lResultStr.IsEmpty then
  begin
    lEditCdCliente.Clear;
    lEditCdCliente.SetFocus;
    Application.MessageBox('Cliente não existe.','Validar Cliente', MB_ICONWARNING);
    Exit;
  end;
  lFieldNomeCliente := (Self.Parent.FindComponent('edtdeNomeCliente') as TDBEdit);
  if Assigned(lFieldNomeCliente) then
    lFieldNomeCliente.Field.Value := lResultStr;
end;

end.
