;***********************************
;迷路仟整理 2019.03.22
;JudgeGadget_判断光标是否在控件内
;***********************************

Enumeration
   #winScreen
   #btnScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "JudgeGadget_判断光标是否在控件内", WindowFlags)

hGadget = ButtonGadget(#btnScreen, 150, 100, 100, 050, "控件")
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MOUSEMOVE
         ;方法1
         GetCursorPos_(@Mouse.q)    ;这里一定要用Q 
         GetWindowRect_(hGadget, GadgetRect.RECT)  
         If PtInRect_(GadgetRect, Mouse) 
            Debug "控件"
         Else 
            Debug "离开"
         EndIf 
         
         ;方法2
;          GetCursorPos_(Mouse.Point)    ;这里一定要用Point
;          GetWindowRect_(hGadget, GadgetRect.RECT)  
;          If PtInRect_(GadgetRect, Mouse\y << 32 | Mouse\x) 
;             Debug "控件"
;          Else 
;             Debug "离开"
;          EndIf 
         
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; FirstLine = 2
; Folding = -
; EnableXP
; EnableOnError