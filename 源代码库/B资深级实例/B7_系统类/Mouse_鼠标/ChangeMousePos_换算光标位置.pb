;***********************************
;迷路仟整理 2019.03.22
;ChangeMousePos_换算光标位置
;***********************************

Enumeration
   #winScreen
   #frmScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ChangeMousePos_换算光标位置", WindowFlags)

hGadget = ContainerGadget(#frmScreen, 050, 050, 300, 150, #PB_Container_Single)

CloseGadgetList()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MOUSEMOVE
         GetCursorPos_(Mouse.POINT)
         Text$ = "屏幕坐标: " + Str(Mouse\x)+","+Str(Mouse\y)
         ScreenToClient_(hWindow, Mouse) 
         Text$ + "  窗体坐标: " + Str(Mouse\x)+","+Str(Mouse\y)
         
         GetCursorPos_(Mouse.POINT)
         ScreenToClient_(hGadget, Mouse) 
         Text$ + "  控件坐标: " + Str(Mouse\x)+","+Str(Mouse\y)
         Debug Text$
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 24
; Folding = -
; EnableXP
; EnableOnError