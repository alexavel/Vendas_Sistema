unit Vendas.Controller.Vendas.Item;

interface

uses
  Vcl.DBCtrls, FireDAC.Comp.Client, Data.DB, System.SysUtils,
  FireDAC.Comp.DataSet, Vcl.Forms, Winapi.Windows, firedac.Stan.Param;
type
  TVendaItemControle = class
  private
    FComponentEmbeded: TObject;
    constructor Create(AEmbeded: TObject);
  public
    destructor Destroy; override;
    class function New(AEmbeded: TObject): TVendaItemControle;
    function CalcularValorQtdeProduto: TVendaItemControle;
    function VerificarProdutoExist: TVendaItemControle;
    function ValidarDadosProduto: TVendaItemControle;
  end;

implementation

uses
  Vendas.Dao;

constructor TVendaItemControle.Create(AEmbeded: TObject);
begin
  FComponentEmbeded := AEmbeded;
end;

destructor TVendaItemControle.Destroy;
begin
  inherited;
end;

class function TVendaItemControle.New (AEmbeded: TObject): TVendaItemControle;
begin
  Result := Self.Create(AEmbeded)
end;

function TVendaItemControle.CalcularValorQtdeProduto: TVendaItemControle;
var
  lEditQtdProduto: TDBEdit;
  lEditvlrProduto: TDBEdit;
  lEditvlrTotal: TDBEdit;
  lValorTotal: Currency;
begin
  Result := Self;
  lEditQtdProduto := TDBEdit(FComponentEmbeded);
  if lEditQtdProduto.Field.IsNull then
    lEditqtdProduto.Field.Value := 1;
  lEditvlrProduto := (lEditQtdProduto.Parent.FindComponent('edtvlUnitario') as TDBEdit);
  lEditvlrTotal := (lEditQtdProduto.Parent.FindComponent('edtvlTotal') as TDBEdit);
  lValorTotal := lEditvlrProduto.Field.Value * lEditqtdProduto.Field.Value;
  lEditvlrTotal.Field.Value := lValorTotal;
end;

function TVendaItemControle.VerificarProdutoExist: TVendaItemControle;
var
  lEditcdProduto: TDBEdit;
  lDataSet: TDataSet;
  lCloneDataSet: TFDMemTable;
  lCountDuplicidade, lCdVenda, lCdProduto: Integer;
begin
  Result := Self;
  lEditcdProduto := TDBEdit(FComponentEmbeded);
  if lEditcdProduto.Text = EmptyStr then
    Exit;

  lCdVenda   := lEditcdProduto.DataSource.DataSet.FieldByName('cdvenda').Value;
  lCdProduto := lEditcdProduto.Field.Value;
  lDataSet   := lEditcdProduto.DataSource.DataSet;
  lCloneDataSet  := TFDMemTable.Create(nil);
  try
    lCloneDataSet.CloneCursor(TFDDataSet(lDataSet));
    lCountDuplicidade := 0;

    lCloneDataSet.First;
    while not lCloneDataSet.Eof do
    begin
      if (lCloneDataSet.FieldByName('cdvenda').Value = lCdVenda) and
         (lCloneDataSet.FieldByName('cdProduto').Value = lCdProduto) then
        Inc(lCountDuplicidade);
      lCloneDataSet.Next;
    end;

    if lCountDuplicidade > 0 then
    begin
        lEditcdProduto.SetFocus;
        Application.MessageBox('Produto já Cadastrado.','Validar Produto', MB_ICONWARNING);
        Exit;
    end;
    ValidarDadosProduto;
  finally
    if Assigned(lCloneDataSet) then
      lCloneDataSet.Free;
  end;
end;

function TVendaItemControle.ValidarDadosProduto: TVendaItemControle;
var
  lQueryConsulta: TFDQuery;
  lQueryStr: string;
  lEditcdProduto, lEditnmProduto, lEditqtdProduto, lEditvlrProduto: TDBEdit;
  lDataSet: TDataSet;
  lCdProduto: Integer;
begin
  Result := Self;
  lEditcdProduto := TDBEdit(FComponentEmbeded);
  if lEditcdProduto.Text = EmptyStr then
    Exit;

  lCdProduto := lEditcdProduto.Field.Value;
  lDataSet   := lEditcdProduto.DataSource.DataSet;
  lQueryConsulta:= TFDQuery.Create(nil);
  try
    lQueryConsulta.Connection := dmVendas.fdConetor;
    lQueryStr  := 'SELECT deDescricao, vlUnitario FROM PRODUTO WHERE cdProduto = :cdProduto and flStatus = 1';
    lQueryConsulta.SQL.Add(lQueryStr);
    lQueryConsulta.ParamByName('cdProduto').Value := lCdProduto;
    lQueryConsulta.Open;
    if lQueryConsulta.IsEmpty then
    begin
      lEditcdProduto.SetFocus;
      Application.MessageBox('Produto não encontrado.','Validar Produto', MB_ICONWARNING);
      Exit;
    end;
    lEditnmProduto := (lEditcdProduto.Parent.FindComponent('edtdeDescricao') as TDBEdit);
    lEditqtdProduto := (lEditcdProduto.Parent.FindComponent('edtnuQuantidade') as TDBEdit);
    lEditvlrProduto := (lEditcdProduto.Parent.FindComponent('edtvlUnitario') as TDBEdit);
    if Assigned(lEditnmProduto) then
    begin
      lDataSet.Edit;
      lEditnmProduto.Field.Value := lQueryConsulta.FieldByName('deDescricao').AsString;
      lEditvlrProduto.Field.Value := lQueryConsulta.FieldByName('vlUnitario').AsCurrency;
      if lEditqtdProduto.Field.IsNull then
        lEditqtdProduto.Field.Value := 1;

      FComponentEmbeded := lEditqtdProduto;
      CalcularValorQtdeProduto;
    end;
  finally
    lQueryConsulta.Free;
  end;
end;

end.
