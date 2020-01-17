;***********************************
;迷路仟整理 2019.01.20
;控件HOOK2
;***********************************


Enumeration
   #winScreen
   #frmScreen
   #lblScreen
EndEnumeration

#GadgetProp$ = "迷路控件"

Structure __GadgetInfo
   hHookGadget.i
EndStructure


Procedure HookGadget_DESTROY(*pGadget.__GadgetInfo, hGadget, wParam, lParam)
   FreeStructure(*pGadget)
   RemoveProp_(hGadget, #GadgetProp$)
EndProcedure 

Procedure HookGadget_MOUSEMOVE(*pGadget.__GadgetInfo, hGadget, wParam, *pMouse.POINTS)
   SetGadgetText(#lblScreen, "X: "+Str(*pMouse\x) + "  Y: " + Str(*pMouse\y))
EndProcedure

Procedure HookGadget(hGadget, uMsg, wParam, lParam)

   *pGadget.__GadgetInfo = GetProp_(hGadget, #GadgetProp$)
   If *pGadget = 0
      ProcedureReturn DefWindowProc_(hGadget, uMsg, wParam, lParam) 
   EndIf 
   Select uMsg
      Case #WM_DESTROY      : Result = HookGadget_DESTROY(*pGadget, hGadget, wParam, lParam)
      Case #WM_MOUSEMOVE    : Result = HookGadget_MOUSEMOVE(*pGadget, hGadget, wParam, @lParam) 
      Case #WM_LBUTTONDOWN    
      Case #WM_LBUTTONUP     
   EndSelect
   If Result = #False
      Result = CallWindowProc_(*pGadget\hHookGadget, hGadget, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "控件HOOK2", WindowFlags)

hGadget = ContainerGadget(#frmScreen, 050, 050, 300, 150, #PB_Container_Raised)
   TextGadget(#lblScreen, 100, 050, 100, 020, "", #PB_Text_Center)
CloseGadgetList()

*pGadget.__GadgetInfo = AllocateStructure(__GadgetInfo)
SetProp_(hGadget, #GadgetProp$, *pGadget)
*pGadget\hHookGadget = SetWindowLongPtr_(hGadget, #GWL_WNDPROC, @HookGadget())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 14
; Folding = -
; EnableXP