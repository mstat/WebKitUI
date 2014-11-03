unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ceflib, AppEvnts, ExtCtrls;

type
  TForm2 = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
    procedure WMNCHitTest(var Msg:TWMNCHitTest); message WM_NCHITTEST;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  MouseInControl:boolean;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.WMNCHitTest(var Msg:TWMNCHitTest);
begin
  DefaultHandler(Msg);
  if Msg.Result = HTCLIENT then
    Msg.Result:= HTCAPTION;
  //form1.Memo1.Lines.Add('x:');
end;

procedure TForm2.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseInControl:=true;  
  case Button of
    mbLeft: form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_LEFT, False, 1);
    mbRight: form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_RIGHT, False, 1);
    mbMiddle: form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_MIDDLE, False, 1);
  end;
  if (Button = mbLeft)and(form1.CheckBox1.Checked) then
    begin
       ReleaseCapture();
       Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
       MouseInControl:=false;
    end;
end;

procedure TForm2.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin           
  MouseInControl:=false;
  case Button of
    mbLeft:   form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_LEFT, True, 1);
    mbRight:  form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_RIGHT, True, 1);
    mbMiddle: form1.ChromiumOSR1.Browser.SendMouseClickEvent(X, Y, MBT_MIDDLE, True, 1);
  end;
end;

procedure TForm2.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin                    
  //form1.memo1.Lines.Add('move '+inttostr(x)+' '+inttostr(y));
  form1.ChromiumOSR1.Browser.SendMouseMoveEvent(X, Y, MouseInControl);
  //MouseInControl:=not MouseInControl;
end;

procedure TForm2.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  info: TCefKeyInfo;
  typ: TCefKeyType;
begin
  case Msg.message of
    WM_CHAR:
      begin
        typ := KT_CHAR;
        info.sysChar := False;
        info.imeChar := False;
      end;
    WM_KEYDOWN:
      begin
        typ := KT_KEYDOWN;
        info.sysChar := False;
        info.imeChar := False;
      end;
    WM_KEYUP:
      begin
        typ := KT_KEYUP;
        info.sysChar := False;
        info.imeChar := False;
      end;

    WM_SYSCHAR:
      begin
        typ := KT_CHAR;
        info.sysChar := True;
        info.imeChar := False;
      end;
    WM_SYSKEYDOWN:
      begin
        typ := KT_KEYDOWN;
        info.sysChar := True;
        info.imeChar := False;
      end;
    WM_SYSKEYUP:
      begin
        typ := KT_KEYUP;
        info.sysChar := True;
        info.imeChar := False;
      end;

    WM_IME_CHAR:
      begin
        typ := KT_CHAR;
        info.sysChar := False;
        info.imeChar := True;
      end;
    WM_IME_KEYDOWN:
      begin
        typ := KT_KEYDOWN;
        info.sysChar := False;
        info.imeChar := True;
      end;
    WM_IME_KEYUP:
      begin
        typ := KT_KEYUP;
        info.sysChar := False;
        info.imeChar := True;
      end;

    WM_MOUSEWHEEL:
      begin
        with TWMMouseWheel(Pointer(@Msg.message)^) do
          form1.ChromiumOSR1.Browser.SendMouseWheelEvent(XPos, YPos, WheelDelta, 0);
        Exit;
      end
  else
    Exit;
  end;
  info.key := Msg.wParam;
  form1.ChromiumOSR1.Browser.SendKeyEvent(typ, info, Msg.lParam);
end;

end.
