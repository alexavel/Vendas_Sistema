inherited frmCliente: TfrmCliente
  Caption = 'frmCliente'
  ClientWidth = 670
  ExplicitHeight = 483
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 540
    ExplicitWidth = 536
    ExplicitHeight = 425
    inherited tbsListagem: TTabSheet
      ExplicitHeight = 396
      inherited dbgListagem: TDBGrid
        Width = 532
        Height = 396
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitHeight = 396
      inherited gpbDetalhes: TGroupBox
        Width = 526
        Height = 390
        ExplicitWidth = 526
        ExplicitHeight = 390
      end
    end
  end
  inherited pnlSide: TPanel
    Left = 543
    ExplicitLeft = 539
    ExplicitHeight = 419
    inherited btnSair: TButton
      Top = 390
      ExplicitTop = 389
    end
  end
  inherited stbFooter: TStatusBar
    Width = 670
    ExplicitTop = 425
    ExplicitWidth = 666
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryCliente
  end
end
