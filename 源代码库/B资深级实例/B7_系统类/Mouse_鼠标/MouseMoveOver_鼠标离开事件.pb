;***********************************
;迷路仟整理 2019.01.26
;MouseMoveOver_鼠标离开事件
;***********************************

Enumeration
   #winScreen
   #btnScreen
   #lblScreen
EndEnumeration



Procedure Event_IsMouseOn(hGadget)  
   GetWindowRect_(hGadget, Rect.RECT)  
   GetCursorPos_(Mouse.POINT)  
   If Mouse\x>=Rect\Left And Mouse\x<=Rect\right And Mouse\y>=Rect\Top And Mouse\y<=Rect\bottom  
      ProcedureReturn #True  
   Else  
      ProcedureReturn #False  
   EndIf  
EndProcedure  


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标移动事件", WindowFlags)

TextGadget  (#lblScreen, 130, 070, 140, 020, "")
hGadget = ButtonGadget(#btnScreen, 130, 150, 140, 050, "按键")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
      Case #WM_MOUSEMOVE
         If Event_IsMouseOn(hGadget)  
            SetGadgetText(#lblScreen, "鼠标在上")
            hMouseOn = hGadget
         EndIf 
      Case #WM_MOUSELEAVE
         If hMouseOn = hGadget
            SetGadgetText(#lblScreen, "鼠标离开")
            hMouseOn = 0
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP
; EnableOnError