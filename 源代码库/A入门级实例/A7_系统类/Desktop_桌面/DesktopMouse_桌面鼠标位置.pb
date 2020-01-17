;***********************************
;迷路仟整理 2019.01.20
;DesktopMouse_桌面鼠标位置
;***********************************

Enumeration
   #winScreen
   #lblScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "DesktopMouse_桌面鼠标位置", WindowFlags)
TextGadget(#lblScreen, 100, 110, 200, 020, "")
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #Null 
         SetGadgetText(#lblScreen, "桌面鼠标位置: "+Str(DesktopMouseX())+","+Str(DesktopMouseY()))
         Delay(10)
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP