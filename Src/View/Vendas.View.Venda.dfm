inherited frmVenda: TfrmVenda
  Caption = 'frmVenda'
  ClientWidth = 976
  ExplicitWidth = 988
  TextHeight = 15
  inherited pgBaseCadasro: TPageControl
    Width = 846
    ActivePage = tbsFormulario
    ExplicitWidth = 846
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 838
      ExplicitHeight = 396
      inherited dbgListagem: TDBGrid
        Width = 838
        Height = 396
      end
    end
    inherited tbsFormulario: TTabSheet
      ExplicitWidth = 838
      ExplicitHeight = 396
      inherited gpbDetalhes: TGroupBox
        Top = 10
        Width = 832
        Height = 383
        Margins.Top = 10
        ExplicitTop = 10
        ExplicitWidth = 832
        ExplicitHeight = 384
        inline frameVendaItem: TframeVendaItem
          Left = 3
          Top = 136
          Width = 826
          Height = 244
          CustomHint = hitBalao
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 136
          ExplicitWidth = 826
          ExplicitHeight = 244
          inherited pnlCenter: TPanel
            Width = 713
            Height = 238
            CustomHint = hitBalao
            ExplicitWidth = 713
            ExplicitHeight = 238
            inherited pgChildBase: TPageControl
              Width = 707
              Height = 225
              CustomHint = hitBalao
              ExplicitWidth = 707
              ExplicitHeight = 225
              inherited tbsChildListagem: TTabSheet
                CustomHint = hitBalao
                ExplicitWidth = 699
                ExplicitHeight = 195
                inherited dbgFrame: TDBGrid
                  Width = 699
                  Height = 195
                  CustomHint = hitBalao
                end
              end
              inherited tbsChildCadastro: TTabSheet
                CustomHint = hitBalao
              end
            end
          end
          inherited pnlSide: TPanel
            Left = 722
            Height = 231
            CustomHint = hitBalao
            ExplicitLeft = 722
            ExplicitHeight = 231
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
          inherited actFrameAcoes: TActionList
            Left = 576
            Top = 99
          end
          inherited dsBaseChild: TDataSource
            Left = 576
            Top = 163
          end
        end
      end
    end
  end
  inherited pnlSide: TPanel
    Left = 849
    ExplicitLeft = 845
    ExplicitHeight = 420
    inherited btnSair: TButton
      Top = 390
      ExplicitTop = 390
    end
  end
  inherited stbFooter: TStatusBar
    Width = 976
    ExplicitTop = 426
    ExplicitWidth = 972
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
