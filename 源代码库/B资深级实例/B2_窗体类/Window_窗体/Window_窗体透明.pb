;***********************************
;迷路仟整理 2019.01.15
;窗体透明,0-255可调
;***********************************


#winScreen = 0
Transparent = 128  ;0-255, 0为全透明,255为正常

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体透明",  WindowFlags)

SetWindowLong_(hWindow, #GWL_EXSTYLE, GetWindowLong_(hWindow,#GWL_EXSTYLE)|#WS_EX_LAYERED)

SetLayeredWindowAttributes_(hWindow, 0, Transparent, 2)
   
Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; EnableXP