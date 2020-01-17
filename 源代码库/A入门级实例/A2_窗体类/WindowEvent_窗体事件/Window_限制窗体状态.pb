;***********************************
;迷路仟整理 2019.01.15
;限制窗体状态
;***********************************

#winScreen = 0

Procedure Window_CallBack(hWindow,uMsg,wParam,lParam)  
   Static IsMinimized  
   Select uMsg  
      Case #WM_SYSCOMMAND  
      Select wParam & $FFFFFFF0  
         Case #SC_MAXIMIZE  
            Beep_(800,100)  
            ProcedureReturn 0  
         Case #SC_MINIMIZE  
            If IsMinimized  
               ResizeWindow(#winScreen, #PB_Ignore,#PB_Ignore,400,250)  
            Else  
               ResizeWindow(#winScreen, #PB_Ignore,#PB_Ignore,400,0)  
            EndIf  
            IsMinimized!1  
            ProcedureReturn 0  
      EndSelect  
   EndSelect  
   ProcedureReturn #PB_ProcessPureBasicEvents  
EndProcedure  


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "限制窗体状态", WindowFlags)
SetWindowCallback(@Window_CallBack())  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; Folding = +
; EnableXP