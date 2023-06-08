unit Vendas.View.Printer.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vendas.View.BasePrinter, Data.DB,
  RLReport;

type
  TfrmPrinterCliente = class(TfrmBasePrinter)
    rllCodigo: TRLLabel;
    rllNome: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbNome: TRLDBText;
    rldbStatus: TRLDBText;
    rllAtivo: TRLLabel;
    procedure rldbStatusBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  end;

implementation

{$R *.dfm}

procedure TfrmPrinterCliente.rldbStatusBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  inherited;
  if AText.ToBoolean then
    AText := 'Ativo'
  else
    AText := 'Inativo';

end;

end.
