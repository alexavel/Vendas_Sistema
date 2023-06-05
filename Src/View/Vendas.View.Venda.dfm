inherited frmVenda: TfrmVenda
  Caption = 'frmVenda'
  ClientHeight = 446
  ClientWidth = 899
  ExplicitWidth = 911
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 769
    Height = 427
    ActivePage = tbsFormulario
    ExplicitWidth = 769
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 761
      inherited dbgListagem: TDBGrid
        Width = 761
        Height = 397
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 761
      inherited gpbDetalhes: TGroupBox
        Top = 10
        Width = 755
        Height = 384
        Margins.Top = 10
        ExplicitTop = 10
        ExplicitWidth = 755
        ExplicitHeight = 384
        inline frameBaseTeste: TframeBase
          Left = 3
          Top = 69
          Width = 749
          Height = 296
          CustomHint = hitBalao
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 69
          ExplicitWidth = 749
          ExplicitHeight = 296
          inherited pnlCenter: TPanel
            Width = 636
            Height = 290
            CustomHint = hitBalao
            ExplicitWidth = 636
            ExplicitHeight = 290
            inherited pgChildBase: TPageControl
              Width = 630
              Height = 277
              CustomHint = hitBalao
              ExplicitWidth = 630
              ExplicitHeight = 277
              inherited tbsChildListagem: TTabSheet
                CustomHint = hitBalao
                inherited dbgFrame: TDBGrid
                  CustomHint = hitBalao
                end
              end
              inherited tbsChildCadastro: TTabSheet
                CustomHint = hitBalao
                ExplicitWidth = 622
                ExplicitHeight = 247
              end
            end
          end
          inherited pnlSide: TPanel
            Left = 645
            Height = 283
            CustomHint = hitBalao
            ExplicitLeft = 645
            ExplicitHeight = 283
            inherited btnNew: TButton
              CustomHint = hitBalao
            end
            inherited btnEdit: TButton
              CustomHint = hitBalao
            end
            inherited btnDel: TButton
              CustomHint = hitBalao
            end
            inherited btnCan: TButton
              CustomHint = hitBalao
            end
            inherited btnSaf: TButton
              CustomHint = hitBalao
            end
          end
        end
      end
    end
  end
  inherited pnlSide: TPanel
    Left = 772
    Height = 421
    ExplicitLeft = 768
    ExplicitHeight = 420
    inherited btnSair: TButton
      Top = 391
      ExplicitTop = 390
    end
  end
  inherited stbFooter: TStatusBar
    Top = 427
    Width = 899
    ExplicitTop = 426
    ExplicitWidth = 895
  end
  inherited actBaseFormulario: TActionList
    Left = 828
    Top = 194
  end
  inherited hitBalao: TBalloonHint
    Left = 836
    Top = 306
  end
  inherited dsBase: TDataSource
    DataSet = dmVendas.qryVenda
    Left = 832
    Top = 248
  end
end
