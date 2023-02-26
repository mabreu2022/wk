object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 553
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 50
    Height = 15
    Caption = 'ID Pessoa'
  end
  object Label3: TLabel
    Left = 16
    Top = 250
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object Label4: TLabel
    Left = 16
    Top = 285
    Width = 62
    Height = 15
    Caption = 'Id Endere'#231'o'
  end
  object Label5: TLabel
    Left = 16
    Top = 321
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object Label6: TLabel
    Left = 16
    Top = 357
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object Label7: TLabel
    Left = 16
    Top = 392
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object Label8: TLabel
    Left = 16
    Top = 428
    Width = 62
    Height = 15
    Caption = 'Logradouro'
  end
  object Label9: TLabel
    Left = 16
    Top = 464
    Width = 77
    Height = 15
    Caption = 'Complemento'
  end
  object Label10: TLabel
    Left = 16
    Top = 75
    Width = 59
    Height = 15
    Caption = 'Fl Natureza'
  end
  object Label11: TLabel
    Left = 16
    Top = 111
    Width = 79
    Height = 15
    Caption = 'Ds Documento'
  end
  object Label12: TLabel
    Left = 16
    Top = 146
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Label13: TLabel
    Left = 16
    Top = 214
    Width = 70
    Height = 15
    Caption = 'Data Registro'
  end
  object Label1: TLabel
    Left = 16
    Top = 181
    Width = 66
    Height = 15
    Caption = 'Sobre Nome'
  end
  object Panel1: TPanel
    Left = 0
    Top = 512
    Width = 1008
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BtnIncluir: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TButton
      Left = 109
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = BtnAlterarClick
    end
    object BtnExcluir: TButton
      Left = 190
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = BtnExcluirClick
    end
    object BtnInserirLotes: TButton
      Left = 279
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Inserir Lote'
      TabOrder = 3
      OnClick = BtnInserirLotesClick
    end
    object BtnSalvar: TButton
      Left = 374
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Salvar'
      Enabled = False
      TabOrder = 4
      OnClick = BtnSalvarClick
    end
    object BtnDBNav: TDBNavigator
      Left = 664
      Top = 6
      Width = 344
      Height = 27
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 5
    end
    object EdtPesquisa: TEdit
      Left = 489
      Top = 9
      Width = 162
      Height = 23
      TabOrder = 6
      TextHint = 'Pesquisa Nome'
      OnKeyPress = EdtPesquisaKeyPress
    end
  end
  object EdtIdPessoa: TEdit
    Left = 120
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object EdtCEP: TEdit
    Left = 120
    Top = 247
    Width = 121
    Height = 23
    TabOrder = 7
    OnExit = EdtCEPExit
  end
  object EdtIdEndereco: TEdit
    Left = 120
    Top = 282
    Width = 329
    Height = 23
    TabOrder = 8
  end
  object EdtUF: TEdit
    Left = 120
    Top = 318
    Width = 329
    Height = 23
    TabOrder = 9
  end
  object EdtCidade: TEdit
    Left = 120
    Top = 354
    Width = 329
    Height = 23
    TabOrder = 10
  end
  object EdtBairro: TEdit
    Left = 120
    Top = 389
    Width = 329
    Height = 23
    TabOrder = 11
  end
  object EdtLogradouro: TEdit
    Left = 120
    Top = 425
    Width = 329
    Height = 23
    TabOrder = 12
  end
  object EdtComplemento: TEdit
    Left = 120
    Top = 461
    Width = 329
    Height = 23
    TabOrder = 13
    OnExit = EdtComplementoExit
  end
  object DBGridPessoas: TDBGrid
    Left = 487
    Top = 0
    Width = 521
    Height = 512
    Align = alRight
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 14
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridPessoasDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'idpessoa'
        Title.Caption = 'ID Pessoa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nmprimeiro'
        Title.Caption = 'Nome'
        Width = 336
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'idendereco'
        Visible = True
      end>
  end
  object EdtFlNatureza: TEdit
    Left = 120
    Top = 72
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object EdtDsDocumento: TEdit
    Left = 120
    Top = 108
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object EdtNMPRIMEIRO: TEdit
    Left = 120
    Top = 143
    Width = 313
    Height = 23
    TabOrder = 4
  end
  object EdtDTREGISTRO: TEdit
    Left = 120
    Top = 211
    Width = 121
    Height = 23
    TabOrder = 6
  end
  object EdtNMSEGUNDO: TEdit
    Left = 120
    Top = 178
    Width = 313
    Height = 23
    TabOrder = 5
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://viacep.com.br/ws'
    Params = <>
    SynchronizedEvents = False
    Left = 488
    Top = 88
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Resource = '09634000/json'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 296
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    Left = 296
    Top = 8
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = MemTable
    FieldDefs = <>
    Response = RESTResponse1
    TypesMode = Rich
    Left = 488
    Top = 16
  end
  object MemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    Left = 488
    Top = 176
  end
  object DataSource1: TDataSource
    Left = 872
    Top = 304
  end
end
