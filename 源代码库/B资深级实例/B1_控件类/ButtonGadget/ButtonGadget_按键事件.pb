;***********************************
;迷路仟整理 2019.01.15
;按键事件
;***********************************

Enumeration
   #WinScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
EndEnumeration

;获取当前鼠标位置的控件句柄
Procedure Event_GetGadget(hWindow)  
   Protected Mouse.POINT  
   GetCursorPos_(@Mouse)  
   MapWindowPoints_(0, hWindow, Mouse, 1)  
   ProcedureReturn ChildWindowFromPoint_(hWindow, Mouse\x|Mouse\y<<32)  
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 200, "按键事件", WindowFlags)

hGadget1 = ButtonGadget(#btnScreen1, 150, 010, 100, 35, "左键单击")
hGadget2 = ButtonGadget(#btnScreen2, 150, 050, 100, 35, "右键单击")
hGadget3 = ButtonGadget(#btnScreen3, 150, 090, 100, 35, "左键双击")
hGadget4 = ButtonGadget(#btnScreen4, 150, 130, 100, 35, "右键双击")
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #WM_LBUTTONDBLCLK : If Event_GetGadget(hWindow) = hGadget3 : Debug "左键双击" : EndIf 
      Case #WM_RBUTTONDBLCLK : If Event_GetGadget(hWindow) = hGadget4 : Debug "右键双击" : EndIf 
      Case #WM_LBUTTONDOWN   : If Event_GetGadget(hWindow) = hGadget1 : Debug "左键单击" : EndIf 
      Case #WM_RBUTTONDOWN   : If Event_GetGadget(hWindow) = hGadget2 : Debug "右键单击" : EndIf 
         
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP