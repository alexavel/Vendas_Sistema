unit Vendas.Controller.Cliente;

interface

uses
  System.Classes, Vendas.Classes.Utils, System.SysUtils ;

Type
  TClienteController = class
    FComponentEmbeded: TObject;
  private
    constructor Create(AEmbeded: TObject);
  public
    class function New(AEmbeded: TObject): TClienteController;
    function ValidarCPF: boolean;
  end;

implementation

uses
  Vcl.DBCtrls;

{ TClienteController }

constructor TClienteController.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

class function TClienteController.New(AEmbeded: TObject): TClienteController;
begin
  Result := Self.Create(AEmbeded)
end;

function TClienteController.ValidarCPF: boolean;
begin
  result := true;
  var lLabeledEdit := TDBLabeledEdit(FComponentEmbeded);
  if not TUtilsRotinas.ValidaCPF(lLabeledEdit.Text) then
  begin
    lLabeledEdit.Clear;
    lLabeledEdit.SetFocus;
    Exit(false);
  end;
end;

end.
