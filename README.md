WebKitUI
========
Delphi (CEF1) - http://code.google.com/p/delphichromiumembedded/

Delphi (CEF3) - http://code.google.com/p/dcef3/

我使用的是 dcef-r306

使用GDI+

flash支持:
CefExtraPluginPaths:=ExtractFileDir(Application.Exename)+'\plugins';


html透明背景渲染必须修改cef调用代码:
info.m_bTransparentPainting:=true;  //添加
