object Form2: TForm2
  Left = 731
  Top = 55
  BorderStyle = bsNone
  Caption = 'Internet Explorer Server'
  ClientHeight = 763
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 795
    Height = 763
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    OnMouseDown = FormMouseDown
    OnMouseMove = FormMouseMove
    OnMouseUp = FormMouseUp
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 24
    Top = 32
  end
end
