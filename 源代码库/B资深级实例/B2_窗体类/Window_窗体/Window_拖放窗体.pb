;***********************************
;迷路仟整理 2019.01.15
;拖放窗体,支持无边框窗体拖放.
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "拖放窗体",  WindowFlags)

Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_LBUTTONDOWN  : SendMessage_(hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP