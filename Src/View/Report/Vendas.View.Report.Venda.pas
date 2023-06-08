unit Vendas.View.Report.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.BaseReport, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, FireDAC.Comp.Client, Vendas.Dao;

type
  TfrmReportVenda = class(TfrmBaseReport)
    edtCliente: TLabeledEdit;
    edtNomeCliente: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
  public
    procedure InicializarRelatorio; override;
  end;

implementation

uses
  Vendas.View.Printer.Venda;

{$R *.dfm}

{ TfrmReportVenda }

procedure TfrmReportVenda.FormCreate(Sender: TObject);
begin
  Printer := TfrmPrinterVenda.Create(Self);
  inherited;

end;

procedure TfrmReportVenda.InicializarRelatorio;
var
  lQuery: string;
begin
  lQuery:= '   SELECT VD.dtEmissao, VD.cdVenda, VD.cdcliente, CL.deNomeCliente, VI.cdProduto, PD.deDescricao, ' +
           '          VI.vlUnitario, VI.nuQuantidade, VI.vlTotal ' +
           '     FROM VENDA VD ' +
           'LEFT JOIN CLIENTE CL ' +
           '       ON CL.cdCliente  = VD.cdcliente ' +
           'LEFT JOIN VENDA_ITEM VI ' +
           '       ON VI.cdvenda = VD.cdVenda ' +
           'LEFT JOIN PRODUTO PD ' +
           '       ON PD.cdProduto = VI.cdProduto ' +
           '    WHERE VD.flStatus = 1 %s ' +
           ' ORDER BY VD.dtEmissao, VD.cdVenda, VD.cdcliente ';
  if edtCliente.Text <> EmptyStr then
    lQuery := Format(lQuery,['AND VD.cdcliente = :CDCLIENTE'])
  else
    lQuery := Format(lQuery,['']);

  GetControlePrint
    .PrepararQuery(lQuery);

  if edtCliente.Text <> EmptyStr then
    GetControlePrint
      .PrepararParametroQuery('CDCLIENTE', edtCliente.Text);

    GetControlePrint.Vizualizar;
end;

procedure TfrmReportVenda.edtClienteExit(Sender: TObject);
begin
  inherited;
  if edtCliente.Text = EmptyStr then
    Exit;

  edtNomeCliente.Text := dmVendas.fdConetor.ExecSQLScalar('SELECT deNomeCliente FROM CLIENTE WHERE CDCLIENTE = :CDCLIENTE',[edtCliente.Text]);
  if edtNomeCliente.Text = EmptyStr then
  begin
    edtCliente.Clear;
    edtCliente.SetFocus;
    raise Exception.Create('Cliente não encontrado');
    Exit;
  end;
end;

end.
