;***********************************
;迷路仟整理 2019.01.15
;获取窗体边框
;***********************************

#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "获取窗体边框", WindowFlags)

GetWindowRect_ (hWindow, RECT.RECT) 
ClientToScreen_(hWindow, Point.Point) 
RECT\Left = Point\X - RECT\Left 
RECT\Top  = Point\Y - RECT\Top 
RECT\right  = RECT\right- Point\X-400
RECT\bottom = RECT\bottom - Point\Y - 250
Debug "左边框: " +  RECT\Left 
Debug "右边框: " +  RECT\right 
Debug "上边框: " +  RECT\Top 
Debug "下边框: " +  RECT\bottom 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableXP