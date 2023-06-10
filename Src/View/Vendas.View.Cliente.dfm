inherited frmCliente: TfrmCliente
  Caption = 'frmCliente'
  ClientWidth = 670
  ExplicitWidth = 682
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 540
    ExplicitWidth = 536
    ExplicitHeight = 424
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 532
      inherited dbgListagem: TDBGrid
        Width = 532
        Height = 395
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 532
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
    ExplicitHeight = 418
    inherited btnSair: TButton
      Top = 389
      ExplicitTop = 388
    end
  end
  inherited stbFooter: TStatusBar
    Width = 670
    ExplicitTop = 424
    ExplicitWidth = 666
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryCliente
  end
end
