object Form1: TForm1
  Left = 192
  Top = 125
  Width = 377
  Height = 140
  Caption = 'Project 2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatusText: TLabel
    Left = 24
    Top = 72
    Width = 59
    Height = 13
    Caption = 'lbStatusText'
  end
  object lbProgressBar1: TLabel
    Left = 24
    Top = 16
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lbMaxProgress: TLabel
    Left = 96
    Top = 16
    Width = 69
    Height = 13
    Caption = 'lbMaxProgress'
  end
  object Button1: TButton
    Left = 168
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Select Dir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 40
    Width = 137
    Height = 21
    TabOrder = 1
    Text = 'D:\TEMP\2023-08-19'
  end
  object bGoClick: TButton
    Left = 248
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Convert DFMs'
    TabOrder = 2
    OnClick = bGoClickClick
  end
  object OpenDialog1: TOpenDialog
    Left = 304
    Top = 24
  end
end
