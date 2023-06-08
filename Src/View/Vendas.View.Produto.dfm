inherited frmProduto: TfrmProduto
  Caption = 'frmProduto'
  ClientHeight = 446
  ExplicitWidth = 678
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Height = 427
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 528
      ExplicitHeight = 396
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 528
      ExplicitHeight = 396
      inherited gpbDetalhes: TGroupBox
        Width = 530
        Height = 392
        ExplicitWidth = 530
        ExplicitHeight = 392
      end
    end
  end
  inherited pnlSide: TPanel
    Height = 421
  end
  inherited stbFooter: TStatusBar
    Top = 427
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryProduto
  end
end
