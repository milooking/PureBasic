;***********************************
;迷路仟整理 2019.01.15
;窗体背景色
;***********************************


#winScreen = 0
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体背景色", WindowFlags)
SetWindowColor(#winScreen, RGB(225,225,255))

Debug "WindowColor = 0x" + Hex(GetWindowColor(#winScreen), #PB_Long)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP