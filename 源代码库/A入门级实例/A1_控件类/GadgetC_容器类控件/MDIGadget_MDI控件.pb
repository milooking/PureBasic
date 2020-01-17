;***********************************
;迷路仟整理 2019.01.20
;列表控件
;***********************************

Enumeration
   #winScreen
   #winChild
   #mdiScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "列表控件", WindowFlags)

   MDIGadget(#mdiScreen, 0, 0, 0, 0, 1, 2, #PB_MDI_AutoSize)
      AddGadgetItem(#mdiScreen, #winChild, "子窗体")
   UseGadgetList(hWindow)


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
; CursorPosition = 18
; Folding = -
; EnableXP