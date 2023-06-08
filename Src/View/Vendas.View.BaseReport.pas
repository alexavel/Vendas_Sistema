unit Vendas.View.BaseReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vendas.Controller.BaseReport, Vendas.View.BasePrinter,
  Vendas.Interfaces.BaseReport;

type
  TfrmBaseReport = class(TForm)
    gbxDetalheRelatorio: TGroupBox;
    gbxControle: TGroupBox;
    btnSair: TButton;
    btnVizualizar: TButton;
    btnImprimir: TButton;
    actEventoImpressao: TActionList;
    actImprimir: TAction;
    actVizualizar: TAction;
    btnCancelar: TAction;
    procedure FormShow(Sender: TObject);
    procedure actVizualizarExecute(Sender: TObject);
    procedure btnCancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FControleReport: IBaseReport;
    FPrinter: TfrmBasePrinter;
    procedure InstanciarFolhaImpressao;
  public
    procedure InicializarRelatorio; virtual; abstract;
    function GetControlePrint: IBaseReport;
    property Printer: TfrmBasePrinter read FPrinter write FPrinter;
  end;

implementation

{$R *.dfm}

procedure TfrmBaseReport.actVizualizarExecute(Sender: TObject);
begin
  InicializarRelatorio;
end;

procedure TfrmBaseReport.btnCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaseReport.FormCreate(Sender: TObject);
begin
  FControleReport := TBaseReportControle.Create(FPrinter)
end;

procedure TfrmBaseReport.FormShow(Sender: TObject);
begin
  InstanciarFolhaImpressao;
end;

function TfrmBaseReport.GetControlePrint: IBaseReport;
begin
  result := FControleReport;
end;

procedure TfrmBaseReport.InstanciarFolhaImpressao;
begin
  if not Assigned(FPrinter) then
  begin
    raise Exception.Create('Error: Sem folha de impressão configurada.');
    Close;
  end;
  FControleReport := TBaseReportControle.New(FPrinter);
end;

end.
