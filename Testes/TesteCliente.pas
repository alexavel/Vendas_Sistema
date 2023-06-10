unit TesteCliente;

interface

uses
  DUnitX.TestFramework, Vendas.Dao, System.SysUtils, Vendas.Interfaces.BaseCadastro,
  Vendas.Controller.BaseCadastro, Vendas.View.Base, Vendas.View.Cliente,
  Vcl.DBCtrls;

type
  [TestFixture]
  TClienteTeste = class
  private
    FFormBaseCadastro: TfrmBaseCadastro;
    FBaseCadastroController: IBaseCadastro;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure TestClienteNovo;
    [Test]
    procedure TestClienteEditar;
    [Test]
    procedure TestClienteExcluir;
    [Test]
    procedure TestClienteValidarCPF;

  end;

var
  csCODIGO_CLIENTE: Integer = 0;
  csNOME_CLIENTE: string = 'Fulano de Tal';
  csNOME_CLIENTE_EDITADO: string = 'Sicrano de Tal';
  csCPF_CLIENTE: string ='88888888888';
  csDTNASCIMENTO_CLIENTE: string = '12/07/1975';
  csFLSTATUS_CLIENTE: Boolean = true;

implementation

uses
  Vendas.Classes.Utils;

procedure TClienteTeste.Setup;
begin
  dmVendas:= TdmVendas.Create(nil);
  FFormBaseCadastro := TfrmCliente.Create(nil);
  FBaseCadastroController := FFormBaseCadastro.BaseCadastroControle;
end;

procedure TClienteTeste.TearDown;
begin
  freeAndNil(dmVendas);
  freeAndNil(FFormBaseCadastro);
end;

procedure TClienteTeste.TestClienteNovo;
begin
  try
    FBaseCadastroController.IniciarAcao(taNovo);
    FFormBaseCadastro.dsBase.DataSet.FieldByName('deNomeCliente').Value := csNOME_CLIENTE;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('nuCpf').Value         := csCPF_CLIENTE;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('dtNascimento').Value  := csDTNASCIMENTO_CLIENTE;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('flStatus').Value      :=  csFLSTATUS_CLIENTE;
    FBaseCadastroController.IniciarAcao(taGravar);

    Assert.IsTrue(FFormBaseCadastro.dsBase.DataSet.FieldByName('cdCliente').AsInteger > csCODIGO_CLIENTE,'Código do cliente mal formatado.');
    Assert.AreEqual(csNOME_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('deNomeCliente').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csCPF_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('nuCpf').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csDTNASCIMENTO_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('dtNascimento').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csFLSTATUS_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('flStatus').AsBoolean,'Nome do cliente não correspondente');
    csCODIGO_CLIENTE:= FFormBaseCadastro.dsBase.DataSet.FieldByName('cdCliente').AsInteger;

    Assert.IsTrue(True,'Gravou com sucesso');
  except on E:Exception do
    begin
      Assert.IsTrue(false,'Erro ao gravar '+ E.Message);
    end;
  end;
end;

procedure TClienteTeste.TestClienteValidarCPF;
const
  csCPF_CORRETO = '76009211387';
  csCPF_INCORRETO = '12652545458';
begin
  Assert.IsTrue(TUtilsRotinas.ValidaCPF(csCPF_CORRETO),'Erro na validação de cpf');
end;

procedure TClienteTeste.TestClienteEditar;
begin
  try
    FFormBaseCadastro.dsBase.DataSet.Last;
    FBaseCadastroController.IniciarAcao(taEditar);
    FFormBaseCadastro.dsBase.DataSet.FieldByName('deNomeCliente').Value := csNOME_CLIENTE_EDITADO;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('nuCpf').Value         := csCPF_CLIENTE;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('dtNascimento').Value  := csDTNASCIMENTO_CLIENTE;
    FFormBaseCadastro.dsBase.DataSet.FieldByName('flStatus').Value      :=  csFLSTATUS_CLIENTE;
    FBaseCadastroController.IniciarAcao(taGravar);

    Assert.AreEqual(csNOME_CLIENTE_EDITADO,FFormBaseCadastro.dsBase.DataSet.FieldByName('deNomeCliente').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csCPF_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('nuCpf').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csDTNASCIMENTO_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('dtNascimento').AsString,'Nome do cliente não correspondente');
    Assert.AreEqual(csFLSTATUS_CLIENTE,FFormBaseCadastro.dsBase.DataSet.FieldByName('flStatus').AsBoolean,'Nome do cliente não correspondente');

    Assert.IsTrue(True,'Editou com sucesso');
  except on E:Exception do
    begin
      Assert.IsTrue(false,'Erro ao Editar '+ E.Message);
    end;
  end;
end;

procedure TClienteTeste.TestClienteExcluir;
begin
  try
    FFormBaseCadastro.dsBase.DataSet.Last;
    FBaseCadastroController.IniciarAcao(taExcluir);

    Assert.IsTrue(True,'Excluido com sucesso');
  except on E:Exception do
    begin
      Assert.IsTrue(false,'Erro ao Excluir '+ E.Message);
    end;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TClienteTeste);

end.
