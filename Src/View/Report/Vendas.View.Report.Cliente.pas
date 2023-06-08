unit Vendas.View.Report.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.BaseReport, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls;

type
  TfrmReportCliente = class(TfrmBaseReport)
    procedure FormCreate(Sender: TObject);
  protected
  public
    procedure InicializarRelatorio; override;
  end;

implementation

uses
  Vendas.View.Printer.Cliente;


{$R *.dfm}

{ TfrmReportCliente }

procedure TfrmReportCliente.FormCreate(Sender: TObject);
begin
  Printer := TfrmPrinterCliente.Create(Self);
  inherited;
end;

procedure TfrmReportCliente.InicializarRelatorio;
var
  lQuery: string;
begin
  lQuery:= 'SELECT * FROM CLIENTE WHERE FLSTATUS = :FLSTATUS';
  GetControlePrint
    .PrepararQuery(lQuery)
    .PrepararParametroQuery('FLSTATUS', true)
    .Vizualizar;
end;

end.
