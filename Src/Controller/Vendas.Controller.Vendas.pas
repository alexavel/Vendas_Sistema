unit Vendas.Controller.Vendas;

interface

uses
  System.Classes, Vendas.Classes.Utils, System.SysUtils ;

Type
  TVendaController = class
    FComponentEmbeded: TObject;
  private
    constructor Create(AEmbeded: TObject);
  public
    class function New(AEmbeded: TObject): TVendaController;
    procedure ValidarCliente;
  end;

implementation

uses
  Vcl.DBCtrls, Vcl.Forms, Winapi.Windows, Vendas.Dao;

{ TVendaController }

constructor TVendaController.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

class function TVendaController.New(AEmbeded: TObject): TVendaController;
begin
  Result := Self.Create(AEmbeded)
end;

procedure TVendaController.ValidarCliente;
var
  lQueryStr, lResultStr: string;
  lEditCdCliente: TDBEdit;
  lFieldNomeCliente: TDBEdit;
begin
  lEditCdCliente := TDBEdit(FComponentEmbeded);

  if lEditCdCliente.Text = EmptyStr then
    Exit;

  lQueryStr  := 'SELECT deNomeCliente FROM CLIENTE WHERE cdCliente = :cdCliente and flStatus = 1';
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
  lFieldNomeCliente := (lEditCdCliente.Parent.FindComponent('edtdeNomeCliente') as TDBEdit);
  if Assigned(lFieldNomeCliente) then
    lFieldNomeCliente.Field.Value := lResultStr;
end;

end.
