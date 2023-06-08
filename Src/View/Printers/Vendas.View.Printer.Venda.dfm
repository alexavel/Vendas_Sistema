inherited frmPrinterVenda: TfrmPrinterVenda
  Caption = 'Relat'#243'rio de Vendas'
  ClientHeight = 638
  ClientWidth = 808
  TextHeight = 15
  inherited rlBase: TRLReport
    inherited rbdCabecalho: TRLBand
      inherited rllSubTitulo: TRLLabel
        Width = 181
        Caption = 'RELAT'#211'RIO DE VENDAS'
        ExplicitWidth = 181
      end
    end
    inherited rlbFooter: TRLBand
      Top = 460
      ExplicitTop = 460
    end
    inherited rlbTitulo: TRLBand
      Height = 18
      Visible = False
      ExplicitHeight = 18
    end
    inherited rlbDetalhe: TRLBand
      Top = 441
      Height = 19
      Visible = False
      ExplicitTop = 441
      ExplicitHeight = 19
    end
    inherited rlgGrupoItem: TRLGroup
      Top = 109
      Height = 332
      DataFields = 'cdVenda'
      Visible = True
      ExplicitTop = 109
      ExplicitHeight = 332
      object rlbCabecarioGrupo: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 81
        BandType = btHeader
        object rllTitCdVenda: TRLLabel
          Left = 32
          Top = 6
          Width = 80
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'd. Venda'
          Layout = tlCenter
        end
        object rldbCdVenda: TRLDBText
          Left = 118
          Top = 6
          Width = 27
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'cdVenda'
          DataSource = dsRelatorioBase
          Holder = rllTitCdVenda
          HoldStyle = hsVertically
          Layout = tlCenter
          Text = ''
        end
        object rllTitCdCliente: TRLLabel
          Left = 33
          Top = 32
          Width = 80
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Cliente'
          Layout = tlCenter
        end
        object rldbCdCliente: TRLDBText
          Left = 118
          Top = 32
          Width = 27
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'cdCliente'
          DataSource = dsRelatorioBase
          Holder = rllTitCdCliente
          HoldStyle = hsVertically
          Layout = tlCenter
          Text = ''
        end
        object rllTitDtVenda: TRLLabel
          Left = 3
          Top = 57
          Width = 109
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data Emiss'#227'o'
          Layout = tlCenter
        end
        object rldbDtEmissao: TRLDBText
          Left = 118
          Top = 57
          Width = 451
          Height = 18
          AutoSize = False
          DataField = 'dtEmissao'
          DataSource = dsRelatorioBase
          Holder = rllTitDtVenda
          HoldStyle = hsVertically
          Layout = tlCenter
          Text = ''
        end
        object rldbDescCliente: TRLDBText
          Left = 151
          Top = 32
          Width = 384
          Height = 18
          AutoSize = False
          DataField = 'deNomeCliente'
          DataSource = dsRelatorioBase
          Holder = rldbCdCliente
          HoldStyle = hsVertically
          Layout = tlCenter
          Text = ''
        end
      end
      object rlbTituloItem: TRLBand
        Left = 0
        Top = 81
        Width = 718
        Height = 24
        BandType = btTitle
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitCodProduto: TRLLabel
          Left = 1
          Top = 1
          Width = 104
          Height = 22
          Align = faLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'd. Produto'
          Layout = tlCenter
        end
        object rllTitDescProduto: TRLLabel
          Left = 105
          Top = 1
          Width = 319
          Height = 22
          Align = faClient
          AutoSize = False
          Caption = 'Nome do Produto'
          Layout = tlCenter
        end
        object rllTitQuantidade: TRLLabel
          Left = 540
          Top = 1
          Width = 80
          Height = 22
          Align = faRight
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtdade'
          Layout = tlCenter
        end
        object rllTItValorUnitario: TRLLabel
          Left = 424
          Top = 1
          Width = 116
          Height = 22
          Align = faRight
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Unit'#225'rio'
          Layout = tlCenter
        end
        object rllTitValorTotal: TRLLabel
          Left = 620
          Top = 1
          Width = 97
          Height = 22
          Align = faRight
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Total'
          Layout = tlCenter
        end
      end
      object rlbDetalheItem: TRLBand
        Left = 0
        Top = 105
        Width = 718
        Height = 26
        object rldbCdProduto: TRLDBText
          Left = 1
          Top = 2
          Width = 104
          Height = 18
          AutoSize = False
          DataField = 'cdProduto'
          DataSource = dsRelatorioBase
          Holder = rllTitCodProduto
          Layout = tlCenter
          Text = ''
        end
        object rldbDescProduto: TRLDBText
          Left = 105
          Top = 3
          Width = 319
          Height = 18
          AutoSize = False
          DataField = 'deDescricao'
          DataSource = dsRelatorioBase
          Holder = rllTitDescProduto
          Layout = tlCenter
          SecondHolder = rldbCdProduto
          SecondHoldStyle = hsVertically
          Text = ''
        end
        object rldbValorUnit: TRLDBText
          Left = 424
          Top = 2
          Width = 116
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'vlUnitario'
          DataSource = dsRelatorioBase
          DisplayMask = 'R$ #0.00'
          Holder = rllTItValorUnitario
          Layout = tlCenter
          SecondHolder = rldbCdProduto
          SecondHoldStyle = hsVertically
          Text = ''
        end
        object rldbQtdade: TRLDBText
          Left = 540
          Top = 3
          Width = 80
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'nuQuantidade'
          DataSource = dsRelatorioBase
          Holder = rllTitQuantidade
          Layout = tlCenter
          SecondHolder = rldbCdProduto
          SecondHoldStyle = hsVertically
          Text = ''
        end
        object rldbValorTotal: TRLDBText
          Left = 620
          Top = 2
          Width = 97
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'vlTotal'
          DataSource = dsRelatorioBase
          DisplayMask = 'R$ #0.00'
          Holder = rllTitValorTotal
          Layout = tlCenter
          SecondHolder = rldbCdProduto
          SecondHoldStyle = hsVertically
          Text = ''
        end
      end
      object rlbSumario: TRLBand
        Left = 0
        Top = 131
        Width = 718
        Height = 62
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.FixedTop = True
        object rllTitTotais: TRLLabel
          Left = 0
          Top = 1
          Width = 104
          Height = 24
          Align = faLeftTop
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Totais'
          Layout = tlCenter
        end
        object rldbrTotalQtdade: TRLDBResult
          Left = 540
          Top = 8
          Width = 80
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'nuQuantidade'
          DataSource = dsRelatorioBase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Holder = rldbQtdade
          Info = riSum
          Layout = tlCenter
          ParentFont = False
          Text = ''
        end
        object rldbrTotalGeral: TRLDBResult
          Left = 620
          Top = 6
          Width = 97
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'vlTotal'
          DataSource = dsRelatorioBase
          DisplayMask = 'R$ #0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Holder = rldbValorTotal
          Info = riSum
          Layout = tlCenter
          ParentFont = False
          Text = ''
        end
      end
    end
  end
end
