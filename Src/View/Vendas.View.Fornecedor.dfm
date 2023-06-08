inherited frmFornecedor: TfrmFornecedor
  Caption = 'frmFornecedor'
  ClientHeight = 446
  ClientWidth = 678
  ExplicitWidth = 690
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 548
    Height = 427
    ExplicitWidth = 548
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 540
      ExplicitHeight = 396
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 540
      ExplicitHeight = 396
      inherited gpbDetalhes: TGroupBox
        Height = 392
        ExplicitWidth = 534
        ExplicitHeight = 392
      end
    end
  end
  inherited pnlSide: TPanel
    Left = 551
    Height = 421
    ExplicitLeft = 551
  end
  inherited stbFooter: TStatusBar
    Top = 427
    Width = 678
    ExplicitWidth = 678
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryFornecedor
  end
end
