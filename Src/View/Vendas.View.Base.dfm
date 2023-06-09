object frmBaseCadastro: TfrmBaseCadastro
  Left = 0
  Top = 0
  CustomHint = hitBalao
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmBaseCadastro'
  ClientHeight = 444
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pgBaseCadasro: TPageControl
    Left = 0
    Top = 0
    Width = 532
    Height = 425
    CustomHint = hitBalao
    ActivePage = tbsListagem
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 540
    ExplicitHeight = 427
    object tbsListagem: TTabSheet
      CustomHint = hitBalao
      Caption = 'Listagem'
      object dbgListagem: TDBGrid
        Left = 0
        Top = 0
        Width = 536
        Height = 398
        CustomHint = hitBalao
        Align = alClient
        DataSource = dsBase
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object tbsFormulario: TTabSheet
      CustomHint = hitBalao
      Caption = 'Formul'#225'rio'
      ImageIndex = 1
      object gpbDetalhes: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 534
        Height = 393
        CustomHint = hitBalao
        Align = alClient
        Caption = 'Informa'#231#245'es do Cadastro'
        TabOrder = 0
        ExplicitWidth = 540
        ExplicitHeight = 158
      end
    end
  end
  object pnlSide: TPanel
    AlignWithMargins = True
    Left = 535
    Top = 3
    Width = 124
    Height = 419
    CustomHint = hitBalao
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 543
    ExplicitHeight = 421
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 5
      Top = 145
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actCancelar
      Align = alTop
      TabOrder = 0
    end
    object btnNovo: TButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actNovo
      Align = alTop
      TabOrder = 1
    end
    object btnAlterar: TButton
      AlignWithMargins = True
      Left = 5
      Top = 40
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actAlterar
      Align = alTop
      TabOrder = 2
    end
    object btnExcluir: TButton
      AlignWithMargins = True
      Left = 5
      Top = 75
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actExcluir
      Align = alTop
      TabOrder = 3
    end
    object btnGravar: TButton
      AlignWithMargins = True
      Left = 5
      Top = 110
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actGravar
      Align = alTop
      TabOrder = 4
    end
    object btnSair: TButton
      AlignWithMargins = True
      Left = 5
      Top = 392
      Width = 114
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      CustomHint = hitBalao
      Action = actSair
      Align = alBottom
      TabOrder = 5
      ExplicitTop = 391
    end
  end
  object stbFooter: TStatusBar
    Left = 0
    Top = 425
    Width = 662
    Height = 19
    CustomHint = hitBalao
    Panels = <>
    ExplicitTop = 427
    ExplicitWidth = 670
  end
  object actBaseFormulario: TActionList
    Tag = 6
    Left = 604
    Top = 186
    object actNovo: TAction
      Tag = 1
      Category = 'Cadastro'
      Caption = 'Novo'
      Hint = 'Para criar um novo registro pressione INSERT'
      ShortCut = 45
      OnExecute = actNovoExecute
    end
    object actAlterar: TAction
      Tag = 2
      Category = 'Cadastro'
      Caption = 'Editar'
      Hint = 'Para editar um registro pressione ENTER'
      ShortCut = 13
      OnExecute = actAlterarExecute
    end
    object actExcluir: TAction
      Tag = 3
      Category = 'Cadastro'
      Caption = 'Excluir'
      Hint = 'Para Excluir um registro pressione DEL'
      ShortCut = 46
      OnExecute = actExcluirExecute
    end
    object actGravar: TAction
      Tag = 4
      Category = 'Cadastro'
      Caption = 'Gravar'
      Hint = 'Para gravar as altera'#231#245'es feita no registro pressione CTRL + S'
      ShortCut = 16467
      OnExecute = actGravarExecute
    end
    object actCancelar: TAction
      Tag = 5
      Category = 'Cadastro'
      Caption = 'Cancelar'
      Hint = 'Para cancelar as altera'#231#245'es pressione ESC'
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
    object actSair: TAction
      Tag = 6
      Category = 'Cadastro'
      Caption = 'Sair'
      Hint = 'Para sair do cadastro pressione CTRL + X'
      ShortCut = 16472
      OnExecute = actSairExecute
    end
  end
  object hitBalao: TBalloonHint
    Left = 612
    Top = 298
  end
  object dsBase: TDataSource
    Left = 608
    Top = 240
  end
end
