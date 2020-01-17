;***********************************
;迷路仟整理 2019.01.15
;窗体激活与挂起
;***********************************

#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体激活与挂起", WindowFlags)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow       : IsExitWindow = #True
      Case #PB_Event_ActivateWindow    : Debug "窗体被激活!"
      Case #PB_Event_DeactivateWindow  : Debug "窗体被挂起!"
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP