;***********************************
;迷路仟整理 2019.01.21
;MovingContainer_移动容器控件
;***********************************

Enumeration
   #winScreen
   #imgScreen
   #picScreen
   #frmScreen
EndEnumeration

;获取当前鼠标位置的控件句柄
Procedure Event_GetGadget(hWindow)  
   Protected Mouse.POINT  
   GetCursorPos_(@Mouse)  
   MapWindowPoints_(0, hWindow, Mouse, 1)  
   ProcedureReturn ChildWindowFromPoint_(hWindow, Mouse\x|Mouse\y<<32)  
EndProcedure 



hImage = LoadImage(#imgScreen, "PureBasic.ico")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "移动容器控件", WindowFlags)
ContainerGadget(#frmScreen, 010, 010, 100, 100, #PB_Container_Flat)
   ImageGadget(#picScreen, 030, 030, 032, 032, hImage)
CloseGadgetList()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #WM_LBUTTONDOWN
         hGadget = Event_GetGadget(hWindow) 
         Select hGadget
            Case GadgetID(#frmScreen)
               SendMessage_(hGadget, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = -
; EnableXP