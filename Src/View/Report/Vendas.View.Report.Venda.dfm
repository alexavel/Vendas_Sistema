inherited frmReportVenda: TfrmReportVenda
  Caption = 'Relat'#243'rio de Venda'
  ClientWidth = 560
  ExplicitWidth = 572
  ExplicitHeight = 162
  TextHeight = 15
  inherited gbxDetalheRelatorio: TGroupBox
    Width = 437
    ExplicitWidth = 433
    ExplicitHeight = 117
    object edtCliente: TLabeledEdit
      Left = 16
      Top = 52
      Width = 89
      Height = 23
      EditLabel.Width = 65
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'd. Cliente'
      TabOrder = 0
      Text = ''
      OnExit = edtClienteExit
    end
    object edtNomeCliente: TLabeledEdit
      Left = 120
      Top = 52
      Width = 297
      Height = 23
      EditLabel.Width = 90
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome do Cliente'
      TabOrder = 1
      Text = ''
    end
  end
  inherited gbxControle: TGroupBox
    Left = 446
    ExplicitLeft = 442
    ExplicitHeight = 117
    inherited btnSair: TButton
      Top = 88
      ExplicitTop = 87
    end
  end
end
