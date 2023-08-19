object Form1: TForm1
  Left = 192
  Top = 125
  Width = 390
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
  PixelsPerInch = 96
  TextHeight = 13
  object mmLog: TMemo
    Left = 0
    Top = 81
    Width = 362
    Height = 198
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 362
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      362
      81)
    object lbProgressBar1: TLabel
      Left = 8
      Top = 8
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbMaxProgress: TLabel
      Left = 80
      Top = 8
      Width = 69
      Height = 13
      Caption = 'lbMaxProgress'
    end
    object lbStatusText: TLabel
      Left = 0
      Top = 64
      Width = 359
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'lbStatusText lbStatusText lbStatusText lbStatusText lbStatusText' +
        ' lbStatusText'
    end
    object ProgressBar1: TProgressBar
      Left = 184
      Top = 8
      Width = 150
      Height = 17
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 137
      Height = 21
      TabOrder = 1
      Text = 'D:\TEMP\2023-08-19'
    end
    object Button1: TButton
      Left = 152
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Select Dir'
      TabOrder = 2
      OnClick = Button1Click
    end
    object bGoClick: TButton
      Left = 232
      Top = 32
      Width = 113
      Height = 25
      Caption = 'Convert DFMs'
      TabOrder = 3
      OnClick = bGoClickClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 72
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 216
    Top = 152
  end
end
