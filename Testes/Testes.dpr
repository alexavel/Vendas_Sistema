program Testes;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  {$ENDIF }
  DUnitX.TestFramework,
  TesteMain in 'TesteMain.pas',
  TesteCliente in 'TesteCliente.pas',
  Vendas.Dao in '..\Src\Dao\Vendas.Dao.pas' {dmVendas: TDataModule},
  Vendas.Controller.BaseCadastro in '..\Src\Controller\Vendas.Controller.BaseCadastro.pas',
  Vendas.Interfaces.BaseCadastro in '..\Src\Interfaces\Vendas.Interfaces.BaseCadastro.pas',
  Vendas.Interfaces.BaseReport in '..\Src\Interfaces\Vendas.Interfaces.BaseReport.pas',
  Vendas.Classes.Atributo in '..\Src\Classes\Vendas.Classes.Atributo.pas',
  Vendas.Classes.NotifyEvents in '..\Src\Classes\Vendas.Classes.NotifyEvents.pas',
  Vendas.Classes.Utils in '..\Src\Classes\Vendas.Classes.Utils.pas',
  Vendas.View.Base in '..\Src\View\Vendas.View.Base.pas' {frmBaseCadastro},
  Vendas.View.Frame.Base in '..\Src\View\Frame\Vendas.View.Frame.Base.pas' {frameBase: TFrame},
  Vendas.Controller.BaseFrame in '..\Src\Controller\Vendas.Controller.BaseFrame.pas',
  Vendas.View.Cliente in '..\Src\View\Vendas.View.Cliente.pas' {frmCliente},
  Vendas.Controller.Cliente in '..\Src\Controller\Vendas.Controller.Cliente.pas';

{$IFDEF TESTINSIGHT}
{$ELSE}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
//    //Generate an NUnit compatible XML File
//    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
//    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
