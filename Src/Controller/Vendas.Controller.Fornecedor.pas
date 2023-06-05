unit Vendas.Controller.Fornecedor;

interface

uses
  System.Classes, Vendas.Classes.Utils, System.SysUtils ;

Type
  TFornecedorController = class
    FComponentEmbeded: TObject;
  private
    constructor Create(AEmbeded: TObject);
  public
    class function New(AEmbeded: TObject): TFornecedorController;
    function ValidarCNPJ: TFornecedorController;
  end;

implementation

uses
  Vcl.DBCtrls;

{ TFornecedorController }

constructor TFornecedorController.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

class function TFornecedorController.New(AEmbeded: TObject): TFornecedorController;
begin
  Result := Self.Create(AEmbeded)
end;

function TFornecedorController.ValidarCNPJ: TFornecedorController;
begin
  result := Self;
  var lLabeledEdit := TDBLabeledEdit(FComponentEmbeded);
  if not TUtilsRotinas.ValidaCNPJ(lLabeledEdit.Text) then
  begin
    lLabeledEdit.Clear;
    lLabeledEdit.SetFocus;
  end;

end;

end.
