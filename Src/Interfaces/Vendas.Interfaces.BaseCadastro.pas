unit Vendas.Interfaces.BaseCadastro;

interface

uses
  System.Generics.Collections, Vcl.ActnList, Vcl.ComCtrls, Vcl.Forms, Data.DB;

type
  TTipoAcao = (taBrowse, taNovo, taEditar, taExcluir, taGravar, taCancelar);
  TArrayAcao = Set of TTipoAcao;

const
  csVizualizacao = [taBrowse,  taExcluir, taGravar, taCancelar];
  csEdicao = [taNovo, taEditar, taExcluir];
  csModEdicao = [taBrowse, taGravar, taExcluir, taCancelar];
  csModPersisten = [taNovo, taEditar];

type
  TDicionarioAcoes = TDictionary<TTipoAcao,TAction>;
  TDicionarioTabSheets = TDictionary<TArrayAcao,TTabSheet>;
  TDicionarioDataSourceFrame = TDictionary<Tframe,TDataSource>;

  IBaseCadastro = interface;

  TRotinaGravaAutomatico = reference to function: IBaseCadastro;

  IBaseCadastro = interface
    ['{AD0F9E33-AE8B-4E76-A8F0-6DFFAF390D3C}']
    /// <summary>
    ///   Função que inicia uma ação do tipo TTipoAcao.
    /// </summary>
    /// <param name="AAcao">
    ///   Parâmetro que instância uma ação no CRUD do tipo: taNovo, taEditar, taExcluir...
    /// </param>
    function IniciarAcao(const AAcao: TTipoAcao): IBaseCadastro;
    function SetGravaAutomatico(AProcedimento: TRotinaGravaAutomatico):IBaseCadastro;
    function GetGravaAutomatico: TRotinaGravaAutomatico;
  end;

implementation

end.
