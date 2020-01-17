;***********************************
;迷路仟整理 2019.01.17
;图文风格按键
;***********************************

Enumeration
   #WinScreen
   #btnScreen
   #imgScreen
EndEnumeration


hImage = LoadImage(#imgScreen, "PureBasic.ico")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "图文风格按键", WindowFlags)

hGaget1 = ButtonGadget(#btnScreen, 150, 100, 120, 050, "   图文风格按键")
hGaget2 = ImageGadget (#imgScreen, 010, 018, 020, 020, hImage)
SetParent_(hGaget2, hGaget1) 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug EventGadget()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
DeleteObject_(hBrush)   
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP