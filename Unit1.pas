unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gdipapi, gdipobj, cefgui, cefvcl, ceflib, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    ChromiumOSR1: TChromiumOSR;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ChromiumOSR1Paint(Sender: TObject;
      const browser: ICefBrowser; kind: TCefPaintElementType;
      dirtyRectsCount: Cardinal; const dirtyRects: PCefRectArray;
      const buffer: Pointer);
    procedure Button2Click(Sender: TObject);
    procedure ChromiumOSR1LoadStart(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame);
    procedure FormShow(Sender: TObject);
    procedure ChromiumOSR1CursorChange(Sender: TObject;
      const browser: ICefBrowser; cursor: HICON);
    procedure ChromiumOSR1BeforePopup(Sender: TObject;
      const parentBrowser: ICefBrowser;
      var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var url: ustring; var client: ICefBase; out Result: Boolean);
    procedure ChromiumOSR1BeforeResourceLoad(Sender: TObject;
      const browser: ICefBrowser; const request: ICefRequest;
      var redirectUrl: ustring; var resourceStream: ICefStreamReader;
      const response: ICefResponse; loadFlags: Integer;
      out Result: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ChromiumOSR1.Load(edit1.Text);
end;

procedure AlphaUpdateLayeredWindow(Wnd: HWND; Bmp: TBitmap; Alpha: Byte);
var
  P: TPoint;
  R: TRect;
  S: TSize;
  BF: _BLENDFUNCTION;
begin
  GetWindowRect(Wnd, R);
  P := Point(0, 0);
  S.cx := Bmp.Width;
  S.cY := Bmp.Height;
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.SourceConstantAlpha := Alpha;
  bf.AlphaFormat := AC_SRC_ALPHA;
  UpdateLayeredWindow(wnd, 0, @R.TopLeft, @S, Bmp.Canvas.Handle, @P, $FFFFFF, @BF, ULW_ALPHA);
end;

function CefGetBitmap(const browser: ICefBrowser; typ: TCefPaintElementType): TBitmap;
var
  w, h, i: Integer;
  p, s: Pointer;
  Bitmap: TBitmap;
begin
  browser.GetSize(PET_VIEW, w, h);
  Bitmap:=TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;
  //Bitmap.Transparent:=true;
  //Bitmap.TransparentColor:=TColor($FF00FF);
{$IFDEF DELPHI12_UP}
  Bitmap.SetSize(w, h);
{$ELSE}
  Bitmap.Width := w;
  Bitmap.Height := h;
{$ENDIF}
  //result:=nil;
  GetMem(p, h * w * 4);
  try
    browser.GetImage(typ, w, h, p);
    s := p;
    for i :=0 to h - 1 do
    begin
      Move(s^, Bitmap.ScanLine[i]^, w*4);
      Inc(Integer(s), w*4);
    end;
    result:=Bitmap;
  finally
    FreeMem(p);
  end;
end;

procedure TForm1.ChromiumOSR1Paint(Sender: TObject;
  const browser: ICefBrowser; kind: TCefPaintElementType;
  dirtyRectsCount: Cardinal; const dirtyRects: PCefRectArray;
  const buffer: Pointer);
var
  Bitmap: TBitmap;
begin
  //memo1.Lines.Add('ChromiumOSR1Paint');
  Bitmap:=CefGetBitmap(Browser,PET_VIEW);
  AlphaUpdateLayeredWindow(Form2.Handle, Bitmap, 255);
  //image1.Canvas.Draw(0,0,Bitmap);
  Bitmap.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  //try
    form2.Left:=0;
    form2.Top:=0;
    form2.Width:=strtoint(edit2.Text);
    form2.Height:=strtoint(edit3.Text);
    ChromiumOSR1.browser.SetSize(PET_VIEW, form2.Width, form2.Height);
    ChromiumOSR1.Browser.SendFocusEvent(True);
    ChromiumOSR1.Browser.Reload;
    form2.Show;
  //except
  //end;
  //SetWindowLong(form2.Handle, GWL_EXSTYLE, GetWindowLong(form2.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
end;

procedure TForm1.ChromiumOSR1LoadStart(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame);
begin
  //frame.Browser.
  memo1.Lines.Add('ChromiumOSR1:LoadStart->'+frame.Url);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  CefExtraPluginPaths:=ExtractFileDir(Application.Exename)+'\plugins';
  ChromiumOSR1.DefaultUrl:='file:///'+ExtractFileDir(Application.Exename)+'/2048-master/index.html';
  ChromiumOSR1.Load('file:///'+ExtractFileDir(Application.Exename)+'/www/index.html');
  //ChromiumOSR1.Load('file:///H:/Project/chromiumUI/aaa.html');
  ChromiumOSR1.browser.SetSize(PET_VIEW, form2.Width, form2.Height);
  ChromiumOSR1.Browser.SendFocusEvent(True);
  edit2.Text:=inttostr(Screen.Width);
  edit3.Text:=inttostr(Screen.Height);
  SetWindowLong(Form2.Handle, GWL_EXSTYLE, GetWindowLong(Form2.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  Button2.Click;
  //self.Left:=0;
  //self.Height:=0;
end;

procedure TForm1.ChromiumOSR1CursorChange(Sender: TObject;
  const browser: ICefBrowser; cursor: HICON);
begin
  SetCursor(cursor);
end;
procedure TForm1.ChromiumOSR1BeforePopup(Sender: TObject;
  const parentBrowser: ICefBrowser; var popupFeatures: TCefPopupFeatures;
  var windowInfo: TCefWindowInfo; var url: ustring; var client: ICefBase;
  out Result: Boolean);
begin
  if pos('hrome-devtools://',url)<1 then
  begin
    ChromiumOSR1.Load(url);
    memo1.Lines.Add('pop:'+copy(url,0,18));
    Result:=true;
  end;
end;

procedure TForm1.ChromiumOSR1BeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const request: ICefRequest;
  var redirectUrl: ustring; var resourceStream: ICefStreamReader;
  const response: ICefResponse; loadFlags: Integer; out Result: Boolean);
begin
  Result:=false;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/index.html';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.Load(uu);            
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/flash.html';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.Load(uu);            
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/2048-master/index.html';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.Load(uu);
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/Ball Pool.htm';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.browser.SetSize(PET_VIEW, form2.Width, form2.Height);
  ChromiumOSR1.Browser.SendFocusEvent(True);
  ChromiumOSR1.Load(uu);
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/jQuery CSS3洗牌效果图片层叠动画在线演示2.html';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.browser.SetSize(PET_VIEW, form2.Width, form2.Height);
  ChromiumOSR1.Browser.SendFocusEvent(True);
  ChromiumOSR1.Load(uu);
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  uu:string;
begin
  uu:='file:///'+ExtractFileDir(Application.Exename)+'/www/CSS Bubbles.html';
  uu:=StringReplace (uu, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  ChromiumOSR1.browser.SetSize(PET_VIEW, form2.Width, form2.Height);
  ChromiumOSR1.Browser.SendFocusEvent(True);
  ChromiumOSR1.Load(uu);
  memo1.Lines.Add(uu);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  ChromiumOSR1.Browser.ShowDevTools;
end;

initialization
  CefCache := 'cache';
  CefUserAgent:='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36';
  
  //CefExtraPluginPaths:='H:\Project\cefUI\plugins';
end.
