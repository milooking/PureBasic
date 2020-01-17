;***********************************
;迷路仟整理 2019.01.17
;展开下拉列表
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "展开下拉列表", WindowFlags)


ButtonGadget  (#btnScreen, 150, 050, 100, 30, "展开下拉列表")
ComboBoxGadget(#cmbScreen, 150, 100, 100, 20) 

 
For k = 1 To 10 
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(k)) 
Next 
SetGadgetState(#cmbScreen, 0)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
            SendMessage_(GadgetID(#cmbScreen), #CB_SHOWDROPDOWN, 1, 1) 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 31
; FirstLine = 2
; Folding = -
; EnableXP