object dlgAbout: TdlgAbout
  Left = 211
  Top = 135
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 115
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 159
    Top = 83
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 369
    Height = 65
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProductName: TLabel
      Left = 67
      Top = 6
      Width = 62
      Height = 13
      Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072':'
      IsControl = True
    end
    object Version: TLabel
      Left = 89
      Top = 23
      Width = 40
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103':'
      IsControl = True
    end
    object Label1: TLabel
      Left = 134
      Top = 6
      Width = 39
      Height = 13
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 134
      Top = 23
      Width = 39
      Height = 13
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 96
      Top = 39
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = #1040#1074#1090#1086#1088':'
      IsControl = True
    end
    object Label4: TLabel
      Left = 134
      Top = 39
      Width = 87
      Height = 13
      Caption = #1064#1077#1089#1090#1072#1082#1086#1074' '#1042'.'#1045'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 8
      Top = 8
      Width = 49
      Height = 49
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    Left = 72
    Top = 136
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 49234
      OnExecute = Action1Execute
    end
  end
end
