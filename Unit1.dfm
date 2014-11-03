object Form1: TForm1
  Left = 1102
  Top = 141
  BorderStyle = bsDialog
  Caption = 'ControlPanel'
  ClientHeight = 357
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 289
    Height = 21
    TabOrder = 0
    Text = 'http://www.baidu.com'
  end
  object Button1: TButton
    Left = 307
    Top = 5
    Width = 33
    Height = 25
    Caption = 'go'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 48
    Width = 105
    Height = 25
    Caption = 'form2'#26032#21021#22987#21270
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 144
    Top = 64
    Width = 241
    Height = 281
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object Button3: TButton
    Left = 16
    Top = 88
    Width = 105
    Height = 25
    Caption = 'UITest'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 128
    Width = 105
    Height = 25
    Caption = 'FlashTest'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 168
    Width = 105
    Height = 25
    Caption = '2048'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 16
    Top = 208
    Width = 105
    Height = 25
    Caption = #37325#21147#29699
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 16
    Top = 248
    Width = 105
    Height = 25
    Caption = #21345#29260#20999#22270
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 16
    Top = 288
    Width = 105
    Height = 25
    Caption = #23631#20445
    TabOrder = 9
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 344
    Top = 5
    Width = 49
    Height = 25
    Caption = 'Debug'
    TabOrder = 10
    OnClick = Button9Click
  end
  object CheckBox1: TCheckBox
    Left = 288
    Top = 40
    Width = 97
    Height = 17
    Caption = #20801#35768#25302#21160
    TabOrder = 11
  end
  object Edit2: TEdit
    Left = 144
    Top = 40
    Width = 49
    Height = 21
    TabOrder = 12
    Text = '0'
  end
  object Edit3: TEdit
    Left = 200
    Top = 40
    Width = 49
    Height = 21
    TabOrder = 13
    Text = '0'
  end
  object ChromiumOSR1: TChromiumOSR
    DefaultUrl = 'file:///H:/Project/cefUI/2048-master/index.html'
    OnBeforePopup = ChromiumOSR1BeforePopup
    OnLoadStart = ChromiumOSR1LoadStart
    OnBeforeResourceLoad = ChromiumOSR1BeforeResourceLoad
    OnPaint = ChromiumOSR1Paint
    OnCursorChange = ChromiumOSR1CursorChange
    Options.AcceleratedPaintingDisabled = False
    Options.AcceleratedFiltersDisabled = False
    Options.AcceleratedPluginsDisabled = False
    Left = 336
    Top = 184
  end
end
