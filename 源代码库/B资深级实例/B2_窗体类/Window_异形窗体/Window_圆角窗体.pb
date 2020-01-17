;***********************************
;迷路仟整理 2019.03.13
;圆角窗体,把窗体四角修成圆角
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "圆角窗体",  WindowFlags)

*pRgnScreen = CreateRoundRectRgn_(000,000,400,250, 50, 50)  ;新建圆角区域
SetWindowRgn_(hWindow, *pRgnScreen, 1)  
   
Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 21
; EnableXP