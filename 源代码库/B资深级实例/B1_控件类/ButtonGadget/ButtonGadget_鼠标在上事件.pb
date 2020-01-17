;***********************************
;迷路仟整理 2019.01.15
;鼠标在上事件
;***********************************

Enumeration
   #WinScreen
   #btnScreen
   #mniScreen
EndEnumeration

Procedure IsMouseOverGadget(hGadget)  
   GetWindowRect_(hGadget, Rect.RECT)  
   GetCursorPos_(Mouse.POINT)  
   If Mouse\x>=Rect\Left And Mouse\x<=Rect\right And Mouse\y>=Rect\Top And Mouse\y<=Rect\bottom  
      ProcedureReturn #True  
   Else  
      ProcedureReturn #False  
   EndIf  
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 250, "鼠标在上事件", WindowFlags)
hGadget = ButtonGadget(#btnScreen, 150, 100, 100, 35, "按键")
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
;       Case #WM_MOUSEMOVE
      Case #WM_MOUSEMOVE
         If IsMouseOverGadget(hGadget)  
            SetGadgetText(#btnScreen, "鼠标在上")
         Else 
            SetGadgetText(#btnScreen, "按键")
         EndIf 
      Case #PB_Event_Menu 

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; FirstLine = 1
; Folding = -
; EnableXP