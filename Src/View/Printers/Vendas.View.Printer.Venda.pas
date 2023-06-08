unit Vendas.View.Printer.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.BasePrinter, Data.DB,
  RLReport;

type
  TfrmPrinterVenda = class(TfrmBasePrinter)
    rlbCabecarioGrupo: TRLBand;
    rlbTituloItem: TRLBand;
    rlbDetalheItem: TRLBand;
    rllTitCdVenda: TRLLabel;
    rldbCdVenda: TRLDBText;
    rllTitCdCliente: TRLLabel;
    rldbCdCliente: TRLDBText;
    rllTitDtVenda: TRLLabel;
    rldbDtEmissao: TRLDBText;
    rllTitCodProduto: TRLLabel;
    rllTitDescProduto: TRLLabel;
    rllTitQuantidade: TRLLabel;
    rllTItValorUnitario: TRLLabel;
    rllTitValorTotal: TRLLabel;
    rldbCdProduto: TRLDBText;
    rldbDescProduto: TRLDBText;
    rldbValorUnit: TRLDBText;
    rldbQtdade: TRLDBText;
    rldbValorTotal: TRLDBText;
    rldbDescCliente: TRLDBText;
    rlbSumario: TRLBand;
    rllTitTotais: TRLLabel;
    rldbrTotalQtdade: TRLDBResult;
    rldbrTotalGeral: TRLDBResult;
  end;

implementation

{$R *.dfm}

end.
