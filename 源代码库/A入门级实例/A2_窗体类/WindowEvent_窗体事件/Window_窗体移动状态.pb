;***********************************
;迷路仟整理 2019.01.15
;窗体移动状态
;***********************************

#winScreen = 0

Procedure Window_Callback(hWinow,uMsg,wParam,lParam) 
   Result = #PB_ProcessPureBasicEvents 
   Select uMsg 
      Case #WM_MOVE ; 
         *pPoint.POINTS = @lParam
         Debug "移动窗体至 -> " + Str(*pPoint\x) + ":" + Str(*pPoint\y) 
   EndSelect 
   ProcedureReturn Result 
EndProcedure 


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体移动状态", WindowFlags)
SetWindowCallback(@Window_CallBack())  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_LBUTTONDOWN  : SendMessage_(hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; Folding = -
; EnableXP