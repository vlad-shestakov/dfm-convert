object Form1: TForm1
  Left = 192
  Top = 125
  Width = 617
  Height = 427
  Caption = 'Project 2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 200
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Sel Dir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 48
    Top = 96
    Width = 137
    Height = 21
    TabOrder = 1
    Text = 'D:\TEMP\2023-08-19'
  end
  object bGoClick: TButton
    Left = 280
    Top = 96
    Width = 75
    Height = 25
    Caption = 'bGoClick'
    TabOrder = 2
    OnClick = bGoClickClick
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 40
  end
end
