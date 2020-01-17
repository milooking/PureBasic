;***********************************
;迷路仟整理 2019.01.20
;列表控件
;***********************************

Enumeration
   #WinScreen
   #lvwScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "列表控件", WindowFlags)

   ListViewGadget(#lvwScreen, 10, 10, 380, 230)
   For i = 1 To 20
      AddGadgetItem (#lvwScreen, -1, "子项 - " + Str(i))
   Next
   SetGadgetState(#lvwScreen, 5)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = -
; EnableXP