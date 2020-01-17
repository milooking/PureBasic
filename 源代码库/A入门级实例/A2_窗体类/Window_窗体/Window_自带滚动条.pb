;***********************************
;迷路仟整理 2019.01.15
;带滚动条的窗体
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget| #WS_VSCROLL|#WS_HSCROLL
       
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "带滚动条的窗体", WindowFlags)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP