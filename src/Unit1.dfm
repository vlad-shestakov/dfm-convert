object Form1: TForm1
  Left = 192
  Top = 125
  Width = 535
  Height = 361
  Caption = #65533#65533#65533#65533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object bOpenDir: TKOLButton
    Tag = 0
    Left = 16
    Top = 80
    Width = 153
    Height = 22
    HelpContext = 0
    IgnoreDefault = True
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = 0
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = False
    DoubleBuffered = False
    Align = caNone
    CenterOnParent = False
    Caption = #65533#65533#65533#65533#65533#65533#65533' '#65533#65533#65533#65533#65533#65533#65533
    Ctl3D = True
    Color = clBtnFace
    parentColor = False
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = -11
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    OnClick = bOpenDirClick
    EraseBackground = False
    Localizy = loForm
    Border = 2
    TextAlign = taCenter
    VerticalAlign = vaCenter
    TabStop = True
    autoSize = False
    DefaultBtn = False
    CancelBtn = False
    windowed = True
    Flat = False
    WordWrap = False
    LikeSpeedButton = False
  end
  object ProgressBar1: TKOLProgressBar
    Tag = 0
    Left = 8
    Top = 48
    Width = 281
    Height = 20
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = 2
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caNone
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = -11
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    Vertical = False
    Smooth = False
    ProgressColor = clHighlight
    ProgressBkColor = clBtnFace
    Progress = 0
    MaxProgress = 100
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
  end
  object Button1: TButton
    Left = 184
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 40
    Top = 128
    Width = 137
    Height = 21
    TabOrder = 3
    Text = 'D:\TEMP\2023-08-19'
  end
  object lDir: TKOLLabel
    Tag = 0
    Left = 8
    Top = 24
    Width = 257
    Height = 17
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = -1
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caNone
    CenterOnParent = False
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = -11
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    TextAlign = taLeft
    VerticalAlign = vaTop
    wordWrap = False
    autoSize = False
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    ShowAccelChar = False
    windowed = True
  end
  object Label1: TKOLLabel
    Tag = 0
    Left = 8
    Top = 8
    Width = 49
    Height = 17
    HelpContext = 0
    IgnoreDefault = False
    AnchorLeft = False
    AnchorTop = False
    AnchorRight = False
    AnchorBottom = False
    AcceptChildren = False
    MouseTransparent = False
    TabOrder = -1
    MinWidth = 0
    MinHeight = 0
    MaxWidth = 0
    MaxHeight = 0
    PlaceDown = False
    PlaceRight = False
    PlaceUnder = False
    Visible = True
    Enabled = True
    DoubleBuffered = False
    Align = caNone
    CenterOnParent = False
    Caption = #65533#65533#65533#65533#65533#65533#65533':'
    Ctl3D = True
    Color = clBtnFace
    parentColor = True
    Font.Color = clWindowText
    Font.FontStyle = []
    Font.FontHeight = -11
    Font.FontWidth = 0
    Font.FontWeight = 0
    Font.FontName = 'MS Sans Serif'
    Font.FontOrientation = 0
    Font.FontCharset = 1
    Font.FontPitch = fpDefault
    Font.FontQuality = fqDefault
    parentFont = True
    EraseBackground = False
    Localizy = loForm
    Transparent = False
    TextAlign = taLeft
    VerticalAlign = vaTop
    wordWrap = False
    autoSize = False
    Brush.Color = clBtnFace
    Brush.BrushStyle = bsSolid
    ShowAccelChar = False
    windowed = True
  end
  object bGoClick: TButton
    Left = 272
    Top = 128
    Width = 75
    Height = 25
    Caption = 'bGoClick'
    TabOrder = 6
    OnClick = bGoClickClick
  end
  object OpenDirDialog1: TKOLOpenDirDialog
    Title = #65533#65533#65533#65533#65533#65533#65533#65533' '#65533#65533#65533#65533#65533#65533#65533' '#65533' dfm-'#65533#65533#65533#65533#65533#65533#65533':'
    Options = [odOnlySystemDirs]
    CenterOnScreen = True
    Localizy = loForm
    AltDialog = False
    Left = 224
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 56
  end
end
