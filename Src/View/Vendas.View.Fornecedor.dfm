inherited frmFornecedor: TfrmFornecedor
  Caption = 'frmFornecedor'
  ClientWidth = 678
  ExplicitHeight = 485
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 548
    ExplicitWidth = 544
    inherited tbsListagem: TTabSheet
      ExplicitHeight = 398
      inherited dbgListagem: TDBGrid
        Height = 398
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitHeight = 398
      inherited gpbDetalhes: TGroupBox
        Height = 392
        ExplicitWidth = 534
        ExplicitHeight = 392
      end
    end
  end
  inherited pnlSide: TPanel
    Left = 551
    ExplicitLeft = 547
    inherited btnSair: TButton
      Top = 392
      ExplicitTop = 391
    end
  end
  inherited stbFooter: TStatusBar
    Width = 678
    ExplicitWidth = 674
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryFornecedor
  end
end
