object dmVendas: TdmVendas
  Height = 442
  Width = 305
  object fdConetor: TFDConnection
    Params.Strings = (
      'Database=DBVendas'
      'User_Name=sa'
      'Password=12936511'
      'Server=NOTEAVEL\SQLEXPRESS'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object fdhDriverMSSql: TFDPhysMSSQLDriverLink
    Left = 136
    Top = 16
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliente'
    Left = 48
    Top = 112
    object cdsClientecdCliente: TAutoIncField
      FieldName = 'cdCliente'
      ReadOnly = True
    end
    object cdsClientedeNomeCliente: TStringField
      FieldName = 'deNomeCliente'
      Size = 100
    end
    object cdsClientenuCpf: TStringField
      FieldName = 'nuCpf'
      Size = 11
    end
    object cdsClienteflStatus: TBooleanField
      FieldName = 'flStatus'
    end
    object cdsClientedtNascimento: TDateField
      FieldName = 'dtNascimento'
    end
  end
  object dspCliente: TDataSetProvider
    DataSet = qryCliente
    Left = 136
    Top = 112
  end
  object qryCliente: TFDQuery
    Connection = fdConetor
    SQL.Strings = (
      'SELECT * '
      '  FROM CLIENTE')
    Left = 224
    Top = 112
    object qryClientecdCliente: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cdCliente'
      ReadOnly = True
    end
    object qryClientedeNomeCliente: TStringField
      DisplayLabel = 'Nome do Cliente'
      FieldName = 'deNomeCliente'
      Size = 100
    end
    object qryClientenuCpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'nuCpf'
      EditMask = '000\.000\.000\-00;0;_'
      Size = 11
    end
    object qryClientedtNascimento: TDateField
      DisplayLabel = 'Data Nascimento'
      FieldName = 'dtNascimento'
      EditMask = '!99/99/00;1;_'
    end
    object qryClienteflStatus: TBooleanField
      DisplayLabel = 'Status'
      FieldName = 'flStatus'
    end
  end
  object cdsFornecedor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFornecedor'
    Left = 48
    Top = 176
    object cdsFornecedorcdFornecedor: TAutoIncField
      FieldName = 'cdFornecedor'
      ReadOnly = True
    end
    object cdsFornecedordeNomeFantasia: TStringField
      FieldName = 'deNomeFantasia'
      Size = 100
    end
    object cdsFornecedordeRazaoSocial: TStringField
      FieldName = 'deRazaoSocial'
      Size = 100
    end
    object cdsFornecedornuCNPJ: TStringField
      DisplayWidth = 14
      FieldName = 'nuCNPJ'
      Size = 14
    end
    object cdsFornecedorflStatus: TBooleanField
      FieldName = 'flStatus'
    end
  end
  object dspFornecedor: TDataSetProvider
    DataSet = qryFornecedor
    Left = 136
    Top = 176
  end
  object qryFornecedor: TFDQuery
    Connection = fdConetor
    SQL.Strings = (
      'SELECT * '
      '  FROM FORNECEDOR')
    Left = 224
    Top = 176
    object qryFornecedorcdFornecedor: TFDAutoIncField
      DisplayLabel = 'C'#243'd. Fornecedor'
      FieldName = 'cdFornecedor'
      Origin = 'cdFornecedor'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryFornecedordeNomeFantasia: TStringField
      DisplayLabel = 'Nome Fantasia'
      FieldName = 'deNomeFantasia'
      Origin = 'deNomeFantasia'
      Size = 100
    end
    object qryFornecedordeRazaoSocial: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'deRazaoSocial'
      Origin = 'deRazaoSocial'
      Size = 100
    end
    object qryFornecedornuCNPJ: TStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'nuCNPJ'
      Origin = 'nuCNPJ'
      EditMask = '00\.000\.000\/0000\-00;0;_'
      Size = 14
    end
    object qryFornecedorflStatus: TBooleanField
      DisplayLabel = 'Status'
      FieldName = 'flStatus'
      Origin = 'flStatus'
    end
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto'
    Left = 48
    Top = 240
    object cdsProdutocdProduto: TAutoIncField
      FieldName = 'cdProduto'
      ReadOnly = True
    end
    object cdsProdutodeDescricao: TStringField
      FieldName = 'deDescricao'
      Size = 100
    end
    object cdsProdutovlUnitario: TBCDField
      FieldName = 'vlUnitario'
      Precision = 10
      Size = 2
    end
    object cdsProdutocdFornecedor: TIntegerField
      FieldName = 'cdFornecedor'
    end
    object cdsProdutoflStatus: TBooleanField
      FieldName = 'flStatus'
    end
  end
  object dspProduto: TDataSetProvider
    DataSet = qryProduto
    Left = 136
    Top = 240
  end
  object qryProduto: TFDQuery
    Connection = fdConetor
    SQL.Strings = (
      'SELECT * '
      '  FROM PRODUTO')
    Left = 224
    Top = 240
    object qryProdutocdProduto: TFDAutoIncField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'cdProduto'
      Origin = 'cdProduto'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryProdutodeDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'deDescricao'
      Origin = 'deDescricao'
      Size = 100
    end
    object qryProdutovlUnitario: TBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vlUnitario'
      Origin = 'vlUnitario'
      DisplayFormat = '#0.00;0;_'
      currency = True
      Precision = 10
      Size = 2
    end
    object qryProdutocdFornecedor: TIntegerField
      DisplayLabel = 'C'#243'd. Fornecedor'
      FieldName = 'cdFornecedor'
      Origin = 'cdFornecedor'
    end
    object qryProdutoflStatus: TBooleanField
      DisplayLabel = 'Status'
      FieldName = 'flStatus'
      Origin = 'flStatus'
    end
  end
  object qryConsultas: TFDQuery
    Connection = fdConetor
    Left = 232
    Top = 16
  end
  object cdsVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    Left = 48
    Top = 304
  end
  object dspVenda: TDataSetProvider
    DataSet = qryVenda
    Left = 136
    Top = 304
  end
  object qryVenda: TFDQuery
    Connection = fdConetor
    SQL.Strings = (
      
        #9'SELECT VD.cdVenda, VD.cdcliente, CL.deNomeCliente, VD.dtEmissao' +
        ', VD.flStatus  '
      #9'  FROM VENDA VD'
      '  LEFT JOIN CLIENTE CL'
      '         ON CL.cdCliente = VD.cdcliente ')
    Left = 224
    Top = 304
    object qryVendacdVenda: TFDAutoIncField
      DisplayLabel = 'C'#243'd. Venda'
      FieldName = 'cdVenda'
      Origin = 'cdVenda'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryVendacdcliente: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'cdcliente'
      Origin = 'cdcliente'
    end
    object qryVendadeNomeCliente: TStringField
      DisplayLabel = 'Nome do Cliente'
      FieldName = 'deNomeCliente'
      LookupDataSet = qryCliente
      LookupKeyFields = 'cdCliente'
      LookupResultField = 'deNomeCliente'
      Origin = 'deNomeCliente'
      ProviderFlags = []
      Size = 100
    end
    object qryVendadtEmissao: TSQLTimeStampField
      DisplayLabel = 'Data Venda'
      FieldName = 'dtEmissao'
      Origin = 'dtEmissao'
      EditMask = '!99/99/0000;1;_'
    end
    object qryVendaflStatus: TBooleanField
      DisplayLabel = 'Efetivada'
      FieldName = 'flStatus'
      Origin = 'flStatus'
    end
  end
  object cdsVendaItem: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVendaItem'
    Left = 48
    Top = 368
  end
  object dspVendaItem: TDataSetProvider
    DataSet = qryVendaItem
    Left = 136
    Top = 368
  end
  object qryVendaItem: TFDQuery
    Connection = fdConetor
    SQL.Strings = (
      
        #9'SELECT VD.cdVendaitem, VD.cdvenda, VD.cdProduto, P.deDescricao,' +
        ' VD.nuQuantidade, VD.vlUnitario, VD.vlTotal, VD.flStatus '
      #9'  FROM VENDA_ITEM VD'
      '  LEFT JOIN PRODUTO P '#9'  '
      '         ON P.cdProduto = VD.cdProduto ')
    Left = 224
    Top = 368
    object qryVendaItemcdVendaitem: TFDAutoIncField
      DisplayLabel = 'Sequencial'
      FieldName = 'cdVendaitem'
      Origin = 'cdVendaitem'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryVendaItemcdvenda: TIntegerField
      DisplayLabel = 'C'#243'd. Venda'
      FieldName = 'cdvenda'
      Origin = 'cdvenda'
    end
    object qryVendaItemcdProduto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'cdProduto'
      Origin = 'cdProduto'
    end
    object qryVendaItemdeDescricao: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'deDescricao'
      Origin = 'deDescricao'
      ProviderFlags = []
      Size = 100
    end
    object qryVendaItemnuQuantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'nuQuantidade'
      Origin = 'nuQuantidade'
    end
    object qryVendaItemvlUnitario: TBCDField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'vlUnitario'
      Origin = 'vlUnitario'
      EditFormat = '#0.00'
      currency = True
      Precision = 10
      Size = 2
    end
    object qryVendaItemvlTotal: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'vlTotal'
      Origin = 'vlTotal'
      EditFormat = '#0.00'
      currency = True
      Precision = 10
      Size = 2
    end
    object qryVendaItemflStatus: TBooleanField
      DisplayLabel = 'Status'
      FieldName = 'flStatus'
      Origin = 'flStatus'
    end
  end
end
