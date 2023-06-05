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

  IBaseCadastro = interface
    ['{AD0F9E33-AE8B-4E76-A8F0-6DFFAF390D3C}']
    function IniciarAcao(const AAcao: TTipoAcao) : IBaseCadastro;
    function Novo: IBaseCadastro;
    function Editar: IBaseCadastro;
    function Excluir: IBaseCadastro;
    function Gravar: IBaseCadastro;
    function Cancelar: IBaseCadastro;
  end;

implementation

end.
