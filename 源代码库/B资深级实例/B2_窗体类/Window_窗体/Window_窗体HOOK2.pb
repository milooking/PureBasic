;***********************************
;迷路仟整理 2019.01.20
;窗体HOOK2
;***********************************


Enumeration
   #winScreen
   #lblScreen
EndEnumeration

#WindowProp$ = "迷路窗体"

Structure __WindowInfo
   hHookWindow.i
EndStructure


Procedure HookWindow_DESTROY(*pWindow.__WindowInfo, hWindow, wParam, lParam)
   FreeStructure(*pWindow)
   RemoveProp_(hWindow, #WindowProp$)
EndProcedure 

Procedure HookWindow_MOUSEMOVE(*pWindow.__WindowInfo, hWindow, wParam, *pMouse.POINTS)
   SetGadgetText(#lblScreen, "X: "+Str(*pMouse\x) + "  Y: " + Str(*pMouse\y))
EndProcedure

Procedure HookWindow(hWindow, uMsg, wParam, lParam)

   *pWindow.__WindowInfo = GetProp_(hWindow, #WindowProp$)
   If *pWindow = 0
      ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam) 
   EndIf 
   Select uMsg
      Case #WM_DESTROY      : Result = HookWindow_DESTROY(*pWindow, hWindow, wParam, lParam)
      Case #WM_MOUSEMOVE    : Result = HookWindow_MOUSEMOVE(*pWindow, hWindow, wParam, @lParam) 
      Case #WM_LBUTTONDOWN    
      Case #WM_LBUTTONUP     
   EndSelect
   If Result = #False
      Result = CallWindowProc_(*pWindow\hHookWindow, hWindow, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体HOOK2", WindowFlags)

TextGadget(#lblScreen, 150, 100, 100, 020, "", #PB_Text_Center)

*pWindow.__WindowInfo = AllocateStructure(__WindowInfo)
SetProp_(hWindow, #WindowProp$, *pWindow)
*pWindow\hHookWindow = SetWindowLongPtr_(hWindow, #GWL_WNDPROC, @HookWindow())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 52
; FirstLine = 35
; Folding = -
; EnableXP