;***********************************
;迷路仟整理 2019.01.20
;数值调节框
;***********************************

Enumeration
   #winScreen
   #spnScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "数值调节框", WindowFlags)

SpinGadget     (#spnScreen, 20, 20, 100, 25, 0, 1000, #PB_Spin_Numeric)
SetGadgetState (#spnScreen, 5) 

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
; CursorPosition = 17
; Folding = -
; EnableXP