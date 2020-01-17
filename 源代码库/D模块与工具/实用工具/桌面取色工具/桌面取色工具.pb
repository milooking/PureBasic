;***********************************
;迷路仟整理 2019.01.15
;桌面取色
;***********************************


Enumeration
   #winScreen
   #cvsScreen 
   #lblScreen 
   #txtScreen 
   #txtColor 
   #tmrScreen 
   #imgScreen 
EndEnumeration

Structure __ScreenInfo
   hScreenDC.i
   hMemoryDC.i
   IsScreenshots.b
EndStructure

Global _Screen.__ScreenInfo

Procedure ZoomScreen(Factor)
   If _Screen\IsScreenshots = #False : ProcedureReturn : EndIf 
   GetCursorPos_(Mouse.POINT)
   StretchBlt_(_Screen\hMemoryDC,0,0,200*Factor+1,200*Factor+1,_Screen\hScreenDC,Mouse\x-(200/Factor)/2,Mouse\y-(200/Factor)/2,201,201,#SRCCOPY)
   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawImage(ImageID(#imgScreen), -5, -5)
      Line(100,000,1,95,#Red)
      Line(000,100,95,1,#Red)
      Line(100,105,1,95,#Red)
      Line(105,100,95,1,#Red)      
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(94,94,12,12, #Red)
      Color = Point(100,100)
      StopDrawing()
      SetGadgetText(#txtScreen, "$"+RSet(Hex(Color), 6, "0"))
      AniColor = RGB(Blue(Color), Green(Color), Red(Color))
      SetGadgetText(#txtColor, "0x"+RSet(Hex(AniColor), 6, "0"))
   EndIf 
EndProcedure

_Screen\hScreenDC = GetDC_(0)
_Screen\hMemoryDC = CreateCompatibleDC_(_Screen\hScreenDC)
hImage = CreateImage(#imgScreen, 210, 210)
SelectObject_(_Screen\hMemoryDC, hImage)


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 200, 240, "桌面取色工具[ESC]", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, 200, 200)
TextGadget  (#lblScreen, 010, 213, 100, 020, "颜色值: ")
StringGadget(#txtScreen, 060, 210, 060, 020, "")
StringGadget(#txtColor,  130, 210, 060, 020, "")
StickyWindow(#winScreen, #True)
AddWindowTimer(#winScreen,#tmrScreen,10)
AddKeyboardShortcut(#winScreen, #PB_Shortcut_Escape, 100)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
      Case #PB_Event_Menu
         If EventMenu() = 100
            If _Screen\IsScreenshots = #True
               Color$ = GetGadgetText(#txtScreen)
               SetClipboardText(Color$)
            EndIf 
            _Screen\IsScreenshots = 1-_Screen\IsScreenshots
            
            If StartDrawing(CanvasOutput(#cvsScreen))
               Line(100,000,1,95,$FF00FF)
               Line(000,100,95,1,$FF00FF)
               Line(100,105,1,95,$FF00FF)
               Line(105,100,95,1,$FF00FF)      
               DrawingMode(#PB_2DDrawing_Outlined)
               Box(94,94,12,12, $FF00FF)
               StopDrawing()
            EndIf 
            
            
         EndIf 
      Case #PB_Event_Timer
         If EventTimer() = #tmrScreen : ZoomScreen(10) : EndIf 
         
   EndSelect
   Delay(1)
Until IsExitWindow = #True

ReleaseDC_(0,_Screen\hScreenDC)
FreeImage(#imgScreen)
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 83
; FirstLine = 57
; Folding = -
; EnableXP
; Executable = ..\..\..\桌面取色.exe