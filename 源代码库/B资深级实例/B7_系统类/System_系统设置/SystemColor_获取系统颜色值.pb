;***********************************
;迷路仟整理 2019.03.15
;SystemColor_获取系统颜色值
;***********************************


Enumeration
   #WinScreen
   #cvsScreen
   #fntScreen
EndEnumeration

Structure __SystemColor
   Number.l    
   Const$
EndStructure 


NewList ListColor.__SystemColor()
*p.__SystemColor
*p = AddElement(ListColor()) : *p\Number = 00 : *p\Const$ = "#COLOR_SCROLLBAR"
*p = AddElement(ListColor()) : *p\Number = 01 : *p\Const$ = "#COLOR_BACKGROUND"
*p = AddElement(ListColor()) : *p\Number = 01 : *p\Const$ = "#COLOR_DESKTOP = #COLOR_BACKGROUND"
*p = AddElement(ListColor()) : *p\Number = 01 : *p\Const$ = "#COLORMATCHTOTARGET_EMBEDED"
*p = AddElement(ListColor()) : *p\Number = 02 : *p\Const$ = "#COLOR_ACTIVECAPTION"
*p = AddElement(ListColor()) : *p\Number = 03 : *p\Const$ = "#COLOR_INACTIVECAPTION"
*p = AddElement(ListColor()) : *p\Number = 03 : *p\Const$ = "#COLORONCOLOR"
*p = AddElement(ListColor()) : *p\Number = 04 : *p\Const$ = "#COLOR_MENU"
*p = AddElement(ListColor()) : *p\Number = 05 : *p\Const$ = "#COLOR_WINDOW"
*p = AddElement(ListColor()) : *p\Number = 06 : *p\Const$ = "#COLOR_WINDOWFRAME"
*p = AddElement(ListColor()) : *p\Number = 07 : *p\Const$ = "#COLOR_MENUTEXT"
*p = AddElement(ListColor()) : *p\Number = 08 : *p\Const$ = "#COLOR_WINDOWTEXT"
*p = AddElement(ListColor()) : *p\Number = 09 : *p\Const$ = "#COLOR_CAPTIONTEXT"
*p = AddElement(ListColor()) : *p\Number = 10 : *p\Const$ = "#COLOR_ACTIVEBORDER"
*p = AddElement(ListColor()) : *p\Number = 11 : *p\Const$ = "#COLOR_INACTIVEBORDER"
*p = AddElement(ListColor()) : *p\Number = 12 : *p\Const$ = "#COLOR_APPWORKSPACE"
*p = AddElement(ListColor()) : *p\Number = 13 : *p\Const$ = "#COLOR_HIGHLIGHT"
*p = AddElement(ListColor()) : *p\Number = 14 : *p\Const$ = "#COLOR_HIGHLIGHTTEXT"
*p = AddElement(ListColor()) : *p\Number = 15 : *p\Const$ = "#COLOR_3DFACE = #COLOR_BTNFACE"
*p = AddElement(ListColor()) : *p\Number = 15 : *p\Const$ = "#COLOR_BTNFACE"
*p = AddElement(ListColor()) : *p\Number = 16 : *p\Const$ = "#COLOR_3DSHADOW = #COLOR_BTNSHADOW"
*p = AddElement(ListColor()) : *p\Number = 16 : *p\Const$ = "#COLOR_BTNSHADOW"
*p = AddElement(ListColor()) : *p\Number = 17 : *p\Const$ = "#COLOR_GRAYTEXT"
*p = AddElement(ListColor()) : *p\Number = 18 : *p\Const$ = "#COLOR_BTNTEXT"
*p = AddElement(ListColor()) : *p\Number = 19 : *p\Const$ = "#COLOR_INACTIVECAPTIONTEXT"
*p = AddElement(ListColor()) : *p\Number = 20 : *p\Const$ = "#COLOR_3DHILIGHT = #COLOR_BTNHIGHLIGHT"
*p = AddElement(ListColor()) : *p\Number = 20 : *p\Const$ = "#COLOR_3DHIGHLIGHT = #COLOR_BTNHIGHLIGHT"
*p = AddElement(ListColor()) : *p\Number = 20 : *p\Const$ = "#COLOR_BTNHIGHLIGHT"
*p = AddElement(ListColor()) : *p\Number = 20 : *p\Const$ = "#COLOR_BTNHILIGHT = #COLOR_BTNHIGHLIGHT"
*p = AddElement(ListColor()) : *p\Number = 21 : *p\Const$ = "#COLOR_3DDKSHADOW"
*p = AddElement(ListColor()) : *p\Number = 22 : *p\Const$ = "#COLOR_3DLIGHT"
*p = AddElement(ListColor()) : *p\Number = 23 : *p\Const$ = "#COLOR_INFOTEXT"
*p = AddElement(ListColor()) : *p\Number = 24 : *p\Const$ = "#COLOR_INFOBK"
*p = AddElement(ListColor()) : *p\Number = 26 : *p\Const$ = "#COLOR_HOTLIGHT"
*p = AddElement(ListColor()) : *p\Number = 27 : *p\Const$ = "#COLOR_GRADIENTACTIVECAPTION"
*p = AddElement(ListColor()) : *p\Number = 28 : *p\Const$ = "#COLOR_GRADIENTINACTIVECAPTION"

hFont = LoadFont(#fntScreen, "宋体", 11)
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 1000, 470, "SystemColor_获取系统颜色值", WindowFlags)

hGadget = CanvasGadget(#cvsScreen, 0, 0, 1000, 470)
If StartDrawing(CanvasOutput(#cvsScreen))
   DrawingFont(hFont) 
   Pos = 10 : X = 10
   ForEach ListColor()
      SysColor = GetSysColor_(ListColor()\Number) 
      
      Box(X+125, Pos+2, 050, 25-3, 0) 
      Box(X+126, Pos+3, 048, 25-5, SysColor) 
      
      BackColor(RGB(255,255,255))
      DrawText(X+000, Pos+5, RSet(Str(ListColor()\Number),3,"0"), 0) 
      DrawText(X+035, Pos+5, "$"+RSet(Hex(SysColor, #PB_Long), 8, "0"), 0) 
      DrawText(X+185, Pos+5, ListColor()\Const$, 0) 
      Pos+25
      If Pos >= 460 
         X   = 490
         Pos = 10
      EndIf 
   Next 
   StopDrawing()
EndIf
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 65
; FirstLine = 45
; Folding = -
; EnableXP
; EnableOnError