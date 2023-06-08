unit Vendas.Interfaces.BaseReport;

interface

uses
  System.Generics.Collections, Vcl.ActnList, Vcl.ComCtrls, Vcl.Forms, Data.DB;

type

  IBaseReport = interface
    ['{AD0F9E33-AE8B-4E76-A8F0-6DFFAF390D3C}']
    /// <summary>
    ///   Obtem a consulta para chamar o relatório
    /// </summary>
    function ObterConsulta: IBaseReport;
    /// <summary>
    ///   Chama a vizualização do Relatorio
    /// </summary>
    function Vizualizar: IBaseReport;
    /// <summary>
    ///   Obtem a string da query
    /// </summary>
    /// <param name="AQuery">
    ///  String da query para fazer a consulta na base de dados
    /// </param>
    function PrepararQuery(const AQuery: string): IBaseReport;
    /// <summary>
    ///   Cria parametros para query
    /// </summary>
    /// <param name="AParaName">
    ///  Nome do paramentro da query
    /// </param>
    /// <param name="AParaName">
    ///  Nome do paramentro da query a ser inserido
    /// </param>
    /// <param name="aParamValue">
    ///  Valor do parâmetro a ser inserido na query
    /// </param>    ///
    function PrepararParametroQuery(const AParaName: string;
      const aParamValue: Variant): IBaseReport;
  end;

implementation

end.
