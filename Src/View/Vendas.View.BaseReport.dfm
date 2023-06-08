object frmBaseReport: TfrmBaseReport
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio Padr'#227'o'
  ClientHeight = 125
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object gbxDetalheRelatorio: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 316
    Height = 119
    Align = alClient
    Caption = 'Relat'#243'rio'
    TabOrder = 0
    ExplicitWidth = 312
    ExplicitHeight = 118
  end
  object gbxControle: TGroupBox
    AlignWithMargins = True
    Left = 325
    Top = 3
    Width = 111
    Height = 119
    Align = alRight
    Caption = 'Controle'
    TabOrder = 1
    ExplicitLeft = 321
    ExplicitHeight = 118
    object btnSair: TButton
      AlignWithMargins = True
      Left = 5
      Top = 89
      Width = 101
      Height = 25
      Action = btnCancelar
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 88
    end
    object btnVizualizar: TButton
      AlignWithMargins = True
      Left = 5
      Top = 51
      Width = 101
      Height = 25
      Action = actVizualizar
      Align = alTop
      TabOrder = 1
    end
    object btnImprimir: TButton
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 101
      Height = 25
      Action = actImprimir
      Align = alTop
      TabOrder = 2
    end
  end
  object actEventoImpressao: TActionList
    Left = 243
    Top = 11
    object actImprimir: TAction
      Category = 'Controle'
      Caption = 'Imprimir'
    end
    object actVizualizar: TAction
      Category = 'Controle'
      Caption = 'Vizualizar'
      OnExecute = actVizualizarExecute
    end
    object btnCancelar: TAction
      Category = 'Controle'
      Caption = 'Sair'
      OnExecute = btnCancelarExecute
    end
  end
end
