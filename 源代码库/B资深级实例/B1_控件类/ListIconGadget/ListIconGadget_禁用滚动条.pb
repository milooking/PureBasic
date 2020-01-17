;***********************************
;迷路仟整理 2019.01.19
;禁用滚动条
;***********************************

Enumeration
   #WinScreen
   #lstScreen
   #btnScreen
EndEnumeration

Global _hHookGadget

Procedure Header_CallBack(hGadget, uMsg, wParam,lParam)  
  Select uMsg
    Case #WM_LBUTTONDOWN,#WM_VSCROLL,#WM_HSCROLL, #WM_MOUSEWHEEL,#WM_KEYDOWN
        If GetGadgetState(#btnScreen) : ProcedureReturn #True : EndIf
  EndSelect
  ProcedureReturn CallWindowProc_(_hHookGadget, hGadget, uMsg, wParam, lParam)
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "ListIconGadget_禁用滚动条", WindowFlags)

ButtonGadget(#btnScreen, 150, 220, 100, 030, "禁用滚动条", #PB_Button_Toggle) 

hGadget = ListIconGadget(#lstScreen, 010, 010, 380, 200,"列-1",110, #PB_ListIcon_FullRowSelect) 
AddGadgetColumn(#lstScreen, 1, "列-2",110)
AddGadgetColumn(#lstScreen, 2, "列-3",110)
For i = 1 To 100
   AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
Next

_hHookGadget = SetWindowLongPtr_(hGadget, #GWL_WNDPROC, @Header_CallBack())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            If GetGadgetState(#btnScreen)
               SetGadgetText(#btnScreen, "启用滚动条")
            Else 
               SetGadgetText(#btnScreen, "禁用滚动条")
            EndIf 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = -
; EnableXP