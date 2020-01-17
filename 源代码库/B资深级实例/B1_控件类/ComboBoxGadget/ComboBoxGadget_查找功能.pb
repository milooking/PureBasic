;***********************************
;迷路仟整理 2019.01.17
;查找功能
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
   #txtScreen
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "查找功能", WindowFlags)


StringGadget  (#txtScreen, 150, 050, 100, 25, "子项-99")
ButtonGadget  (#btnScreen, 150, 080, 100, 30, "查找")
ComboBoxGadget(#cmbScreen, 150, 120, 100, 25) 

 
For k = 1 To 100
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(k)) 
Next 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
            FindText$ = GetGadgetText(#txtScreen)
            Pos = SendMessage_(GadgetID(#cmbScreen), #CB_FINDSTRING, 0, @FindText$) 
            SetGadgetState(#cmbScreen, Pos)
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; FirstLine = 2
; Folding = -
; EnableXP