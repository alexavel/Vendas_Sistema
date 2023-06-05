inherited frmCliente: TfrmCliente
  Caption = 'frmCliente'
  ExplicitWidth = 686
  ExplicitHeight = 485
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 536
      ExplicitHeight = 398
      inherited dbgListagem: TDBGrid
        Width = 536
        Height = 398
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 536
      ExplicitHeight = 398
      inherited gpbDetalhes: TGroupBox
        ExplicitHeight = 392
      end
    end
  end
  inherited pnlSide: TPanel
    inherited btnSair: TButton
      Top = 392
      ExplicitTop = 391
    end
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryCliente
  end
end
