unit Vendas.View.Frame.VendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.Frame.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vendas.Classes.Atributo,  Vendas.Dao,
  FireDAC.Comp.Client, Vcl.DBCtrls, FireDAC.Comp.DataSet, FireDAC.Stan.Param;

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

{$R *.dfm}

{ TframeVendaItem }

procedure TframeVendaItem.CalcularPreçoProduto(Sender: TObject);
begin
  CalcularValorQtdeProduto(Sender);
end;

procedure TframeVendaItem.CalcularValorQtdeProduto(Sender: TObject);
var
  lEditQtdProduto: TDBEdit;
  lEditvlrProduto: TDBEdit;
  lEditvlrTotal: TDBEdit;
  lValorTotal: Currency;
begin
  lEditQtdProduto := TDBEdit(Sender);
  if lEditQtdProduto.Field.IsNull then
    lEditqtdProduto.Field.Value := 1;
  lEditvlrProduto := (Self.Parent.FindComponent('edtvlUnitario') as TDBEdit);
  lEditvlrTotal := (Self.Parent.FindComponent('edtvlTotal') as TDBEdit);
  lValorTotal := lEditvlrProduto.Field.Value * lEditqtdProduto.Field.Value;
  lEditvlrTotal.Field.Value := lValorTotal;
end;

procedure TframeVendaItem.VerificarProduto(Sender: TObject);
var
  lQueryConsulta: TFDQuery;
  lQueryStr: string;
  lEditcdProduto, lEditnmProduto, lEditqtdProduto, lEditvlrProduto: TDBEdit;
  lDataSet: TDataSet;
  lCloneDataSet: TFDMemTable;
  lCountDuplicidade, lCdVenda, lCdProduto: Integer;
begin
  lEditcdProduto := TDBEdit(Sender);
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
    lCloneDataSet.EnableControls;

    if lCountDuplicidade > 1 then
    begin
        lEditcdProduto.SetFocus;
        lCloneDataSet.Free;
        Application.MessageBox('Produto já Cadastrado.','Validar Produto', MB_ICONWARNING);
        Exit;
    end;
  finally
    lCloneDataSet.Free;
  end;

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
    lEditnmProduto := (Self.Parent.FindComponent('edtdeDescricao') as TDBEdit);
    lEditqtdProduto := (Self.Parent.FindComponent('edtnuQuantidade') as TDBEdit);
    lEditvlrProduto := (Self.Parent.FindComponent('edtvlUnitario') as TDBEdit);
    if Assigned(lEditnmProduto) then
    begin
      lDataSet.Edit;
      lEditnmProduto.Field.Value := lQueryConsulta.FieldByName('deDescricao').AsString;
      lEditvlrProduto.Field.Value := lQueryConsulta.FieldByName('vlUnitario').AsCurrency;
      if lEditqtdProduto.Field.IsNull then
        lEditqtdProduto.Field.Value := 1;

      CalcularValorQtdeProduto(lEditqtdProduto);
    end;
  finally
    lQueryConsulta.Free;
  end;
end;


end.
