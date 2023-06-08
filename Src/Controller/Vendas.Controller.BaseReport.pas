unit Vendas.Controller.BaseReport;

interface

uses
  Vendas.Interfaces.BaseReport, Vendas.View.BasePrinter, Vcl.Forms, Data.db,
  FireDAC.Stan.Param, FireDAC.Comp.Client, Vendas.Dao, System.SysUtils;

type
  TBaseReportControle = class(TInterfacedObject, IBaseReport)
  private
    FPrint: TfrmBasePrinter;
    FData: TFDQuery;
  public
    constructor Create(APrint: TfrmBasePrinter);
    destructor Destroy; override;
    class function New(APrint: TfrmBasePrinter): IBaseReport;
    function PrepararQuery(const AQuery: string): IBaseReport;
    function PrepararParametroQuery(const AParaName: string;
      const aParamValue: Variant): IBaseReport;
    function ObterConsulta: IBaseReport;
    function Vizualizar: IBaseReport;
  end;

implementation

constructor TBaseReportControle.Create(APrint: TfrmBasePrinter);
begin
  FPrint:= APrint;
  FData := TFDQuery.Create(nil);
  FData.Connection := dmVendas.fdConetor;
end;

destructor TBaseReportControle.Destroy;
begin
  if Assigned(FData) then
    FData.Free;
  inherited;
end;

class function TBaseReportControle.New(APrint: TfrmBasePrinter): IBaseReport;
begin
  Result:= Self.Create(APrint);
end;

function TBaseReportControle.ObterConsulta: IBaseReport;
begin
  Result := Self;
end;

function TBaseReportControle.PrepararQuery(const AQuery: string): IBaseReport;
begin
  result := Self;
  FData.Close;
  FData.SQL.Clear;
  FData.Params.Clear;
  FData.SQL.Add(AQuery);
end;

function TBaseReportControle.PrepararParametroQuery(const AParaName: string;
  const aParamValue: Variant): IBaseReport;
begin
  result := Self;
  FData.ParamByName(AParaName).Value := aParamValue
end;

function TBaseReportControle.Vizualizar: IBaseReport;
begin
  result := Self;
  FData.Open;
  if FData.IsEmpty then
  begin
    raise Exception.Create('Não há registros');
    Exit;

  end;
  FPrint.dsRelatorioBase.DataSet := FData;
  FPrint.rlBase.PreviewModal;
end;

end.
