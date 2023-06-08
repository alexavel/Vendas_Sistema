inherited frmPrinterCliente: TfrmPrinterCliente
  Caption = 'frmPrinterCliente'
  TextHeight = 15
  inherited rlBase: TRLReport
    inherited rlbTitulo: TRLBand
      object rllCodigo: TRLLabel
        Left = 0
        Top = 0
        Width = 57
        Height = 23
        Align = faLeft
        AutoSize = False
        Caption = 'C'#243'digo'
        Layout = tlCenter
      end
      object rllNome: TRLLabel
        Left = 57
        Top = 0
        Width = 504
        Height = 23
        Align = faLeft
        Caption = 'Nome do Cliente'
        Layout = tlCenter
      end
      object rllAtivo: TRLLabel
        Left = 660
        Top = 0
        Width = 58
        Height = 23
        Align = faRight
        Alignment = taCenter
        AutoSize = False
        Caption = 'Situa'#231#227'o'
        Layout = tlCenter
      end
    end
    inherited rlbDetalhe: TRLBand
      object rldbCodigo: TRLDBText
        Left = 0
        Top = 5
        Width = 57
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'cdCliente'
        DataSource = dsRelatorioBase
        Layout = tlCenter
        Text = ''
      end
      object rldbNome: TRLDBText
        Left = 57
        Top = 5
        Width = 350
        Height = 18
        AutoSize = False
        DataField = 'deNomeCliente'
        DataSource = dsRelatorioBase
        Layout = tlCenter
        Text = ''
      end
      object rldbStatus: TRLDBText
        Left = 660
        Top = 7
        Width = 58
        Height = 18
        Alignment = taCenter
        AutoSize = False
        DataField = 'flStatus'
        DataSource = dsRelatorioBase
        Holder = rllAtivo
        Layout = tlCenter
        Text = ''
        BeforePrint = rldbStatusBeforePrint
      end
    end
    inherited rlgGrupoItem: TRLGroup
      Visible = False
    end
  end
end
