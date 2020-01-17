;***********************************
;迷路仟整理 2019.01.15
;获取窗体颜色:背景色,前景色 
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体颜色",  WindowFlags)

BackColor  = GetSysColor_(#COLOR_BTNFACE)     ;获取窗体背景色
FrontColor = GetSysColor_(#COLOR_WINDOWTEXT)  ;获取窗体前景色 

Debug "窗体背景色 = 0x" + Hex(BackColor)
Debug "窗体前景色 = 0x" + Hex(FrontColor)

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
; CursorPosition = 2
; EnableXP