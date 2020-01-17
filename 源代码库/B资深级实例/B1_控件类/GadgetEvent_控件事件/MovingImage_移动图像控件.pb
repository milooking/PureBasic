;***********************************
;迷路仟整理 2019.02.07
;MovingImage_移动图像控件
;***********************************

Enumeration
   #winScreen
   #imgScreen
   #picScreen
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
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "移动图像控件", WindowFlags)

ImageGadget(#picScreen, 030, 030, 032, 032, hImage)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget
         Select EventGadget()
            Case #picScreen : GadgetID = #picScreen
            Default  : GadgetID = -1
         EndSelect      
      Case #WM_LBUTTONUP : GadgetID = -1
      Case #WM_MOUSEMOVE
         If GetAsyncKeyState_(#VK_LBUTTON) And GadgetID >0
            SendMessage_(GadgetID(GadgetID), #WM_SYSCOMMAND, #SC_MOVE + #HTCLIENT, 0)
         EndIf
      Default:GadgetID = -1

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 9
; Folding = -
; EnableXP