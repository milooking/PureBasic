;***********************************
;迷路仟整理 2019.01.15
;标准窗体生成实例
;***********************************


#winScreen = 0
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "标准窗体", WindowFlags)
Repeat
   WinEvent  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow
      Case #PB_Event_Gadget
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; EnableXP