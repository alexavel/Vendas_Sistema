unit Vendas.Dao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider, Datasnap.DBClient;

type
  TdmVendas = class(TDataModule)
    fdConetor: TFDConnection;
    fdhDriverMSSql: TFDPhysMSSQLDriverLink;
    cdsCliente: TClientDataSet;
    dspCliente: TDataSetProvider;
    qryCliente: TFDQuery;
    cdsClientecdCliente: TAutoIncField;
    cdsClientedeNomeCliente: TStringField;
    cdsClientenuCpf: TStringField;
    cdsClienteflStatus: TBooleanField;
    cdsClientedtNascimento: TDateField;
    qryClientecdCliente: TFDAutoIncField;
    qryClientedeNomeCliente: TStringField;
    qryClientenuCpf: TStringField;
    qryClienteflStatus: TBooleanField;
    qryClientedtNascimento: TDateField;
    cdsFornecedor: TClientDataSet;
    dspFornecedor: TDataSetProvider;
    qryFornecedor: TFDQuery;
    qryFornecedorcdFornecedor: TFDAutoIncField;
    qryFornecedordeNomeFantasia: TStringField;
    qryFornecedordeRazaoSocial: TStringField;
    qryFornecedornuCNPJ: TStringField;
    qryFornecedorflStatus: TBooleanField;
    cdsFornecedorcdFornecedor: TAutoIncField;
    cdsFornecedordeNomeFantasia: TStringField;
    cdsFornecedordeRazaoSocial: TStringField;
    cdsFornecedornuCNPJ: TStringField;
    cdsFornecedorflStatus: TBooleanField;
    cdsProduto: TClientDataSet;
    dspProduto: TDataSetProvider;
    qryProduto: TFDQuery;
    qryProdutocdProduto: TFDAutoIncField;
    qryProdutodeDescricao: TStringField;
    qryProdutovlUnitario: TBCDField;
    qryProdutocdFornecedor: TIntegerField;
    qryProdutoflStatus: TBooleanField;
    qryConsultas: TFDQuery;
    cdsVenda: TClientDataSet;
    dspVenda: TDataSetProvider;
    qryVenda: TFDQuery;
    cdsProdutocdProduto: TAutoIncField;
    cdsProdutodeDescricao: TStringField;
    cdsProdutovlUnitario: TBCDField;
    cdsProdutocdFornecedor: TIntegerField;
    cdsProdutoflStatus: TBooleanField;
    qryVendacdVenda: TFDAutoIncField;
    qryVendacdcliente: TIntegerField;
    qryVendadtEmissao: TSQLTimeStampField;
    qryVendaflStatus: TBooleanField;
    cdsVendaItem: TClientDataSet;
    dspVendaItem: TDataSetProvider;
    qryVendaItem: TFDQuery;
    qryVendaItemcdVendaitem: TFDAutoIncField;
    qryVendaItemcdvenda: TIntegerField;
    qryVendaItemcdProduto: TIntegerField;
    qryVendaItemnuQuantidade: TIntegerField;
    qryVendaItemvlUnitario: TBCDField;
    qryVendaItemvlTotal: TBCDField;
    qryVendaItemflStatus: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmVendas: TdmVendas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
