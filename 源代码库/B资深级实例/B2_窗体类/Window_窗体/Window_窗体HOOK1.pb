;***********************************
;迷路仟整理 2019.01.20
;窗体HOOK1
;***********************************



#winScreen = 0
#lblScreen = 0

Global _hHookWindow.i


Procedure HookWindow_DESTROY(hWindow, wParam, lParam)

EndProcedure 

Procedure HookWindow_MOUSEMOVE(hWindow, wParam, *pMouse.POINTS)

   SetGadgetText(#lblScreen, "X: "+Str(*pMouse\x) + "  Y: " + Str(*pMouse\y))
EndProcedure

Procedure HookWindow(hWindow, uMsg, wParam, lParam)
   Select uMsg
      Case #WM_DESTROY      : Result = HookWindow_DESTROY(hWindow, wParam, lParam)
      Case #WM_MOUSEMOVE    : Result = HookWindow_MOUSEMOVE(hWindow, wParam, @lParam) 
      Case #WM_LBUTTONDOWN    
      Case #WM_LBUTTONUP     
   EndSelect
   If Result = #False
      Result = CallWindowProc_(_hHookWindow, hWindow, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体HOOK1", WindowFlags)

TextGadget(#lblScreen, 150, 100, 100, 020, "", #PB_Text_Center)
_hHookWindow = SetWindowLongPtr_(hWindow, #GWL_WNDPROC, @HookWindow())
   
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; Folding = 5
; EnableXP