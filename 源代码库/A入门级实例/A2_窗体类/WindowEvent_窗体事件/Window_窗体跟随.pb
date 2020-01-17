;***********************************
;迷路仟整理 2019.01.15
;窗体跟随
;***********************************

#winScreen1 = 0
#winScreen2 = 1

Procedure Window_Callback(hWindow,uMsg,wParam,lParam)  
   Result=#PB_ProcessPureBasicEvents  
   Select uMsg 
      Case #WM_MOVE
         If hWindow = WindowID(#winScreen1)
            GetWindowRect_(hWindow,win.RECT)
            x=win\left 
            y=win\top 
            w=win\right-win\left 
            SetWindowPos_(WindowID(#winScreen2),0,x+w,y,0,0,#SWP_NOSIZE|#SWP_NOACTIVATE)  
         EndIf 
         Result = 0
   EndSelect  
   ProcedureReturn Result  
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow1 = OpenWindow(#winScreen1, 0, 0, 400, 250, "主窗体", WindowFlags)
hWindow2 = OpenWindow(#winScreen2, 0, 0, 100, 250, "跟随窗体", WindowFlags, hWindow1)
SetWindowCallback(@Window_Callback())
ResizeWindow(#winScreen1, WindowX(#winScreen1)-1, #PB_Ignore,#PB_Ignore,#PB_Ignore)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow       : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = +
; EnableXP