object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Sistemas de Vendas'
  ClientHeight = 267
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnMain
  WindowState = wsMaximized
  TextHeight = 15
  object mnMain: TMainMenu
    Left = 32
    Top = 24
    object V1: TMenuItem
      Caption = 'Cadastros'
      object Cliente1: TMenuItem
        Action = actCliente
      end
      object Fornecedores1: TMenuItem
        Action = actFornecedor
      end
      object Fornecedores2: TMenuItem
        Action = actProduto
      end
    end
    object Movimentaes1: TMenuItem
      Caption = 'Movimenta'#231#245'es'
      object Vendas1: TMenuItem
        Action = actVenda
      end
    end
  end
  object actMain: TActionList
    Left = 32
    Top = 88
    object actCliente: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de &Clientes'
      OnExecute = actClienteExecute
    end
    object actFornecedor: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de &Fornecedores'
      OnExecute = actFornecedorExecute
    end
    object actProduto: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de &Produtos'
      OnExecute = actProdutoExecute
    end
    object actVenda: TAction
      Category = 'Movimentacao'
      Caption = 'Vendas'
      OnExecute = actVendaExecute
    end
  end
end
