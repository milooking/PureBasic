;***********************************
;迷路仟整理 2019.01.15
;Callback事件
;***********************************

Procedure Window_Callback(hWnd, uMsg, wParam, lParam) 
   If uMsg = #WM_SIZE 
      Select WParam 
         Case #SIZE_MINIMIZED 
            Debug "窗体最小化" 
         Case #SIZE_RESTORED 
            Debug "窗体正常化" 
         Case #SIZE_MAXIMIZED 
            Debug "窗体最大化" 
      EndSelect 
   EndIf 
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 
  
#winScreen = 0
WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget
OpenWindow(#winScreen, 0, 0, 400, 250, "Callback事件", WindowFlags) 
    SetWindowCallback(@Window_Callback())    ; 启用Callback

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; Folding = +
; EnableXP