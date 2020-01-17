;***********************************
;迷路仟整理 2019.01.21
;调整窗体
;***********************************

#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, Random(500, 350), Random(300, 200), "调整窗体", WindowFlags)

Debug "======Resize前======="
Debug "X = " + WindowX(#winScreen)
Debug "Y = " + WindowY(#winScreen)
Debug "W = " + WindowWidth(#winScreen)
Debug "H = " + WindowHeight(#winScreen)

;#PB_Ignore : 表示默认,即采用原来的大小或位置, 
ResizeWindow(#winScreen, #PB_Ignore, #PB_Ignore, 400, 100)
Debug "======Resize后======="
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
; CursorPosition = 23
; EnableXP