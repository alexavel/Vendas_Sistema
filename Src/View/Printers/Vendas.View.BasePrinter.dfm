object frmBasePrinter: TfrmBasePrinter
  Left = 0
  Top = 0
  Caption = 'frmBasePrinter'
  ClientHeight = 638
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object rlBase: TRLReport
    Left = -8
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsRelatorioBase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    object rbdCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 53
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object rllTitulo: TRLLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 159
        Height = 18
        Margins.Bottom = 10
        Caption = 'SISTEMA DE VENDAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlsData: TRLSystemInfo
        Left = 673
        Top = 0
        Width = 45
        Height = 17
        Align = faRightTop
        Text = ''
      end
      object rllSubTitulo: TRLLabel
        AlignWithMargins = True
        Left = 0
        Top = 24
        Width = 196
        Height = 18
        Margins.Top = 10
        Caption = 'RELAT'#211'RIO DE CLIENTES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbFooter: TRLBand
      Left = 38
      Top = 162
      Width = 718
      Height = 48
      BandType = btFooter
      object rlsPaginas: TRLSystemInfo
        Left = 618
        Top = 0
        Width = 100
        Height = 17
        Align = faRightTop
        Info = itPageNumber
        Text = ''
      end
    end
    object rlbTitulo: TRLBand
      Left = 38
      Top = 91
      Width = 718
      Height = 24
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
    end
    object rlbDetalhe: TRLBand
      Left = 38
      Top = 137
      Width = 718
      Height = 25
    end
    object rlgGrupoItem: TRLGroup
      Left = 38
      Top = 115
      Width = 718
      Height = 22
      Visible = False
    end
  end
  object dsRelatorioBase: TDataSource
    Left = 472
  end
end
