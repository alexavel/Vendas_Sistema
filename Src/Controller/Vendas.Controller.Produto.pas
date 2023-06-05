unit Vendas.Controller.Produto;

interface

uses
  System.Classes, Vendas.Classes.Utils, System.SysUtils ;

Type
  TProdutoController = class
    FComponentEmbeded: TObject;
  private
    constructor Create(AEmbeded: TObject);
  public
    class function New(AEmbeded: TObject): TProdutoController;
    function validarPreco: TProdutoController;
    function validarFornecedor: TProdutoController;
  end;

implementation

uses
  Vcl.DBCtrls, Vcl.Forms, Winapi.Windows, Vendas.Dao;

{ TProdutoController }

constructor TProdutoController.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

class function TProdutoController.New(AEmbeded: TObject): TProdutoController;
begin
  Result := Self.Create(AEmbeded)
end;

function TProdutoController.validarPreco: TProdutoController;
begin
  result := Self;
  var lLabeledEdit := TDBLabeledEdit(FComponentEmbeded);
  if StrToCurrDef(lLabeledEdit.Text,0) = 0 then
  begin
    lLabeledEdit.Clear;
    lLabeledEdit.SetFocus;
    Application.MessageBox('O valor do produto informado, não é válido',
      'Validador de Preço', MB_ICONWARNING);
  end;
end;

function TProdutoController.validarFornecedor: TProdutoController;
const
  csATIVO = 1;
begin
  result := Self;
  var lLabeledEdit := TDBLabeledEdit(FComponentEmbeded);
  var lCDFornecedor := StrToIntDef(lLabeledEdit.Text,0);
  var lExiste :=  dmVendas
                    .fdConetor
                    .ExecSQLScalar('select count(*) from fornecedor where cdfornecedor = :cdfornecedor and flstatus = :flstatus', [lCDFornecedor,csATIVO]);
  if (lCDFornecedor > 0) and (lExiste = 0) then
  begin
    lLabeledEdit.Clear;
    lLabeledEdit.SetFocus;
    Application.MessageBox('O Fornecedor não existe ou está inativo.',
      'Validador Fornecedor', MB_ICONWARNING);
  end;
end;

end.
