unit Vendas.View.BasePrinter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, RLReport;

type
  TfrmBasePrinter = class(TForm)
    rlBase: TRLReport;
    dsRelatorioBase: TDataSource;
    rbdCabecalho: TRLBand;
    rllTitulo: TRLLabel;
    rlsData: TRLSystemInfo;
    rlbFooter: TRLBand;
    rlsPaginas: TRLSystemInfo;
    rllSubTitulo: TRLLabel;
    rlbTitulo: TRLBand;
    rlbDetalhe: TRLBand;
    rlgGrupoItem: TRLGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasePrinter: TfrmBasePrinter;

implementation

{$R *.dfm}

end.
