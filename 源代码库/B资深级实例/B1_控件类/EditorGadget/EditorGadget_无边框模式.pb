;***********************************
;迷路仟整理 2019.03.28
;EditorGadget_无边框模式
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "EditorGadget_无边框模式", WindowFlags)
hGadget = EditorGadget(#rtxScreen, 005, 005, 390, 200, #PB_String_BorderLess)
SetGadgetText (#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")

ExStyle  = GetWindowLongPtr_(hGadget, #GWL_EXSTYLE)
NewStyle = ExStyle & (~#WS_EX_CLIENTEDGE)
SetWindowLongPtr_(hGadget, #GWL_EXSTYLE, NewStyle)
;   ResizeGadget(#rtxScreen, 005, 005, 390, 200)
SetWindowTheme_(hGadget, @null.w, @null.w)
SetWindowPos_(hGadget, 0, 0, 0, 0, 0, #SWP_SHOWWINDOW | #SWP_NOSIZE | #SWP_NOMOVE | #SWP_FRAMECHANGED) 


SendMessage_(hGadget,#EM_SETOPTIONS,#ECOOP_OR,#ECO_AUTOVSCROLL|#ECO_AUTOHSCROLL|#ECO_READONLY)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP