;***********************************
;迷路仟整理 2019.01.21
;窗体尺寸
;***********************************

#winScreen = 0


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, Random(500, 350), Random(300, 200), "窗体尺寸", WindowFlags)

Debug "X = " + WindowX(#winScreen)
Debug "Y = " + WindowY(#winScreen)
Debug "W = " + WindowWidth(#winScreen)
Debug "H = " + WindowHeight(#winScreen)

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
; CursorPosition = 8
; EnableXP