program Venda;

uses
  Vcl.Forms,
  Vendas.View.Principal in 'Src\View\Vendas.View.Principal.pas' {frmMain},
  Vendas.View.Base in 'Src\View\Vendas.View.Base.pas' {frmBaseCadastro},
  Vendas.Interfaces.BaseCadastro in 'Src\Interfaces\Vendas.Interfaces.BaseCadastro.pas',
  Vendas.Controller.BaseCadastro in 'Src\Controller\Vendas.Controller.BaseCadastro.pas',
  Vendas.Classes.Atributo in 'Src\Classes\Vendas.Classes.Atributo.pas',
  Vendas.Dao in 'Src\Dao\Vendas.Dao.pas' {dmVendas: TDataModule},
  Vendas.View.Fornecedor in 'Src\View\Vendas.View.Fornecedor.pas' {frmFornecedor},
  Vendas.View.Produto in 'Src\View\Vendas.View.Produto.pas' {frmProduto},
  Vendas.Classes.Utils in 'Src\Classes\Vendas.Classes.Utils.pas',
  Vendas.Controller.Cliente in 'Src\Controller\Vendas.Controller.Cliente.pas',
  Vendas.Controller.Fornecedor in 'Src\Controller\Vendas.Controller.Fornecedor.pas',
  Vendas.Controller.Produto in 'Src\Controller\Vendas.Controller.Produto.pas',
  Vendas.View.Venda in 'Src\View\Vendas.View.Venda.pas' {frmVenda},
  Vendas.View.Frame.Base in 'Src\View\Frame\Vendas.View.Frame.Base.pas' {frameBase: TFrame},
  Vendas.Controller.BaseFrame in 'Src\Controller\Vendas.Controller.BaseFrame.pas',
  Vendas.Controller.Vendas in 'Src\Controller\Vendas.Controller.Vendas.pas',
  Vendas.View.Cliente in 'Src\View\Vendas.View.Cliente.pas' {frmCliente},
  Vendas.View.Frame.VendaItem in 'Src\View\Frame\Vendas.View.Frame.VendaItem.pas' {frameVendaItem: TFrame},
  Vendas.View.BaseReport in 'Src\View\Vendas.View.BaseReport.pas' {frmBaseReport},
  Vendas.View.BasePrinter in 'Src\View\Printers\Vendas.View.BasePrinter.pas' {frmBasePrinter},
  Vendas.Controller.BaseReport in 'Src\Controller\Vendas.Controller.BaseReport.pas',
  Vendas.Interfaces.BaseReport in 'Src\Interfaces\Vendas.Interfaces.BaseReport.pas',
  Vendas.View.Report.Cliente in 'Src\View\Report\Vendas.View.Report.Cliente.pas' {frmReportCliente},
  Vendas.View.Printer.Cliente in 'Src\View\Printers\Vendas.View.Printer.Cliente.pas' {frmPrinterCliente},
  Vendas.View.Report.Venda in 'Src\View\Report\Vendas.View.Report.Venda.pas' {frmReportVenda},
  Vendas.View.Printer.Venda in 'Src\View\Printers\Vendas.View.Printer.Venda.pas' {frmPrinterVenda};

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmVendas, dmVendas);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
