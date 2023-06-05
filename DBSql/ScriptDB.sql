IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DBVendas')
BEGIN
	CREATE DATABASE DBVendas
END
GO

USE DBVendas;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='cliente' and xtype='U')
BEGIN
    CREATE TABLE cliente (
        cdCliente		INT PRIMARY KEY IDENTITY (1, 1),
		deNomeCliente	VARCHAR(100),
		nuCpf           VARCHAR(11) UNIQUE,
		flStatus        BIT DEFAULT 1,
		dtNascimento    DATE
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='fornecedor' and xtype='U')
BEGIN
    CREATE TABLE fornecedor (
        cdFornecedor	INT PRIMARY KEY IDENTITY (1, 1),
		deNomeFantasia	VARCHAR(100),
		deRazaoSocial	VARCHAR(100),
		nuCNPJ          VARCHAR(14) UNIQUE,
		flStatus        BIT DEFAULT 1
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='produto' and xtype='U')
BEGIN
    CREATE TABLE produto (
        cdProduto	    INT PRIMARY KEY IDENTITY (1, 1),
		deDescricao		VARCHAR(100),
		vlUnitario	    NUMERIC(10,2) CHECK(vlUnitario > 0),
		cdFornecedor    INT,
		flStatus        BIT DEFAULT 1,
	    CONSTRAINT PK_PRODUTO_FORNECEDOR FOREIGN KEY(cdFornecedor) REFERENCES fornecedor(cdFornecedor)	
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='venda' and xtype='U')
BEGIN
    CREATE TABLE venda (
        cdVenda     	INT PRIMARY KEY IDENTITY (1, 1),
		cdcliente       INT,
		dtEmissao       DATETIME, 	
		flStatus        BIT DEFAULT 1,
	    CONSTRAINT PK_VENDA_CLIENTE FOREIGN KEY(cdcliente) REFERENCES cliente(cdcliente)
	);
END;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='venda_item' and xtype='U')
BEGIN
    CREATE TABLE venda_item (
        cdVendaitem    	INT PRIMARY KEY IDENTITY (1, 1),
		cdvenda         INT,
		cdProduto       INT,
		nuQuantidade    INT  CHECK(nuQuantidade > 0),	
		vlUnitario	    NUMERIC(10,2) CHECK(vlUnitario > 0),		
		vlTotal		    NUMERIC(10,2) CHECK(vlTotal > 0),		
		flStatus        BIT DEFAULT 1,
	    CONSTRAINT PK_VENDA_ITEM_VENDA FOREIGN KEY(cdvenda) REFERENCES venda(cdvenda) ON DELETE CASCADE,
		CONSTRAINT PK_VENDA_ITEM_PRODUTO FOREIGN KEY(cdProduto) REFERENCES produto(cdProduto)
	);
END;
GO



