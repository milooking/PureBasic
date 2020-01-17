;***********************************
;迷路仟整理 2019.01.20
;快捷键控件
;***********************************

Enumeration
   #winScreen
   #stkScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "快捷键控件: 自动捕捉并显示键盘按键", WindowFlags)

ShortcutGadget(#stkScreen, 20, 20, 200, 25, #PB_Shortcut_Control | #PB_Shortcut_A)
SetActiveGadget(#stkScreen)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; Folding = -
; EnableXP