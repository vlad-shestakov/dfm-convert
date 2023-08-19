object Form1: TForm1
  Left = 192
  Top = 125
  Width = 392
  Height = 330
  BorderWidth = 6
  Caption = 'DFM Converter'
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 390
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmLog: TMemo
    Left = 0
    Top = 65
    Width = 364
    Height = 195
    Align = alClient
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 364
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      364
      65)
    object lbProgressBar1: TLabel
      Left = 120
      Top = 24
      Width = 6
      Height = 13
      Caption = '0'
      Visible = False
    end
    object lbMaxProgress: TLabel
      Left = 144
      Top = 24
      Width = 69
      Height = 13
      Caption = 'lbMaxProgress'
      Visible = False
    end
    object lbStatusText: TLabel
      Left = 40
      Top = 24
      Width = 18
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = '123'
      Visible = False
    end
    object Label1: TLabel
      Left = 5
      Top = 6
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'DIR'
    end
    object Label2: TLabel
      Left = 7
      Top = 38
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Progress'
    end
    object Label3: TLabel
      Left = 198
      Top = 38
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Ext.'
    end
    object ProgressBar1: TProgressBar
      Left = 56
      Top = 36
      Width = 137
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 32
      Top = 2
      Width = 225
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'D:\TEMP\2023-08-19'
    end
    object Button1: TButton
      Left = 264
      Top = 0
      Width = 99
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Select Dir'
      TabOrder = 2
      OnClick = Button1Click
    end
    object bGoClick: TButton
      Left = 264
      Top = 32
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Convert DFMs'
      TabOrder = 3
      OnClick = bGoClickClick
    end
    object edExt: TEdit
      Left = 224
      Top = 34
      Width = 33
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 3
      TabOrder = 4
      Text = 'ext'
      OnExit = edExtExit
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 260
    Width = 364
    Height = 19
    Panels = <
      item
        Text = 'Status Panel Text'
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 56
    Top = 88
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 16
    Top = 88
  end
end
