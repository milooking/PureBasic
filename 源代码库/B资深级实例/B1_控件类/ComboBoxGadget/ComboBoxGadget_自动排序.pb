;***********************************
;迷路仟整理 2019.01.17
;自动排序
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "自动排序", WindowFlags)


hGadget = ComboBoxGadget(#cmbScreen, 150, 050, 100, 20, #CBS_SORT) 
For k = 1 To 10 
   SendMessage_(hGadget, #CB_ADDSTRING, 0, "子项-"+Str(Random(100))) 
Next 
SetGadgetState(#cmbScreen, 0)

  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug EventGadget()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = -
; EnableXP