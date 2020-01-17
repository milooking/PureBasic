;***********************************
;迷路仟整理 2019.03.22
;GetHandle_获取光标所指控件句柄
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "GetHandle_获取光标所指控件句柄", WindowFlags)

hGadget1 = ButtonGadget(#btnScreen1, 030, 050, 150, 050, "控件1")
hGadget2 = ButtonGadget(#btnScreen2, 030, 120, 150, 050, "控件2")
hGadget3 = ButtonGadget(#btnScreen3, 220, 050, 150, 050, "控件3")
hGadget4 = ButtonGadget(#btnScreen4, 220, 120, 150, 050, "控件4")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MOUSEMOVE
         ;方法1
         GetCursorPos_(@Mouse.q)    ;这里一定要用Q
         hGadget = WindowFromPoint_(Mouse) 
;          ;方法2
;          GetCursorPos_(Mouse.Point)    ;这里一定要用Point
;          hGadget = WindowFromPoint_(Mouse\y << 32 | Mouse\x) 
         
         Select hGadget
            Case hGadget1 : Debug "控件1 - " + Str(hGadget)
            Case hGadget2 : Debug "控件2 - " + Str(hGadget)
            Case hGadget3 : Debug "控件3 - " + Str(hGadget)
            Case hGadget4 : Debug "控件4 - " + Str(hGadget)
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP
; EnableOnError