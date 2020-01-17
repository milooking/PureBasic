;***********************************
;迷路仟整理 2019.01.15
;组合窗体
;***********************************



#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "组合窗体", WindowFlags)
SetWindowColor(#winScreen, $CFFFFF)

RgnB = CreateEllipticRgn_(10,5, 080, 250)  
RgnA = CreateRoundRectRgn_(98, 8, 410, 250, 30, 30)  
GRgn = RgnA  
CombineRgn_(GRgn, GRgn, RgnB, #RGN_OR)  
SetWindowRgn_(hWindow, GRgn, #True)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; EnableXP