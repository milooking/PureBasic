;***********************************
;迷路仟整理 2019.03.22
;MouseRealPos_获取光标屏幕位置
;***********************************

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "MouseRealPos_获取光标屏幕位置", WindowFlags)

hGadget = CanvasGadget(#cvsScreen, 050, 050, 300, 150)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         If EventGadget() = #cvsScreen
            Mouse.Point
            Mouse\X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
            Mouse\Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
            Text$ = "控件坐标: " + Str(Mouse\x)+","+Str(Mouse\y)
            ClientToScreen_(hGadget, Mouse) 
            Text$ + "  屏幕坐标: " + Str(Mouse\x)+","+Str(Mouse\y)
            Debug Text$
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP
; EnableOnError