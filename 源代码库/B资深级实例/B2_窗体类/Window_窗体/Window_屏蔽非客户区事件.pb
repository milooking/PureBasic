;***********************************
;迷路仟整理 2019.02.02
;屏蔽非客户区事件
;***********************************

Global _hHookWindow.i
Global _hCurSor = LoadCursor_(0, #IDC_ARROW) 
  
Procedure Hook_Window(hWindow, uMsg, wParam, lParam)
   Select uMsg
      Case #WM_NCLBUTTONDOWN  
         Select wParam
            Case #HTCAPTION
               Result = #True  ;屏蔽移动窗体事件
            Case #HTLEFT, #HTTOP, #HTTOPLEFT
               Result = #True  ;屏蔽左拉,上拉,左上拉事件(调整窗体事件)
         EndSelect
   EndSelect
   If Result = #False
      Result = CallWindowProc_(_hHookWindow, hWindow, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure

#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "屏蔽非客户区事件", WindowFlags)

_hHookWindow = SetWindowLongPtr_(hWindow, #GWL_WNDPROC, @Hook_Window())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; FirstLine = 6
; Folding = -
; EnableXP