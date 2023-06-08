object frameBase: TframeBase
  Left = 0
  Top = 0
  Width = 640
  Height = 324
  TabOrder = 0
  object pnlCenter: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 527
    Height = 318
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pgChildBase: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 10
      Width = 521
      Height = 305
      Margins.Top = 10
      ActivePage = tbsChildListagem
      Align = alClient
      TabOrder = 0
      object tbsChildListagem: TTabSheet
        Caption = 'tbsChildListagem'
        object dbgFrame: TDBGrid
          Left = 0
          Top = 0
          Width = 513
          Height = 275
          Align = alClient
          DataSource = dsBaseChild
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object tbsChildCadastro: TTabSheet
        Caption = 'tbsChildCadastro'
        ImageIndex = 1
      end
    end
  end
  object pnlSide: TPanel
    AlignWithMargins = True
    Left = 536
    Top = 10
    Width = 101
    Height = 311
    Margins.Top = 10
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnNew: TButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 91
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = actNew
      Align = alTop
      TabOrder = 0
    end
    object btnEdit: TButton
      AlignWithMargins = True
      Left = 5
      Top = 40
      Width = 91
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = actEdit
      Align = alTop
      TabOrder = 1
    end
    object btnDel: TButton
      AlignWithMargins = True
      Left = 5
      Top = 75
      Width = 91
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = actDel
      Align = alTop
      TabOrder = 2
    end
    object btnCan: TButton
      AlignWithMargins = True
      Left = 5
      Top = 145
      Width = 91
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = actCan
      Align = alTop
      TabOrder = 3
    end
    object btnSaf: TButton
      AlignWithMargins = True
      Left = 5
      Top = 110
      Width = 91
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = actSaf
      Align = alTop
      TabOrder = 4
    end
  end
  object actFrameAcoes: TActionList
    Left = 568
    Top = 163
    object actNew: TAction
      Category = 'Cadastro'
      Caption = 'Novo'
      ShortCut = 16429
      OnExecute = actNewExecute
    end
    object actEdit: TAction
      Category = 'Cadastro'
      Caption = 'Editar'
      ShortCut = 16449
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Category = 'Cadastro'
      Caption = 'Delete'
      ShortCut = 16430
      OnExecute = actDelExecute
    end
    object actCan: TAction
      Category = 'Cadastro'
      Caption = 'Cancelar'
      ShortCut = 8219
      OnExecute = actCanExecute
    end
    object actSaf: TAction
      Category = 'Cadastro'
      Caption = 'Gravar'
      ShortCut = 24659
      OnExecute = actSafExecute
    end
  end
  object dsBaseChild: TDataSource
    Left = 568
    Top = 227
  end
end
