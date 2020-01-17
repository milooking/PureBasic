;***********************************
;迷路仟整理 2019.01.21
;控件提示文
;***********************************

Enumeration
   #winScreen
   #btnScreen
   #chkScreen
   #ptnScreen
   #cmbScreen
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "控件提示文", WindowFlags)

ButtonGadget  (#btnScreen, 10, 015, 200, 30, "按键") 
CheckBoxGadget(#chkScreen, 10, 060, 200, 20, "复选框") 
OptionGadget  (#ptnScreen, 10, 090, 200, 20, "选项框") 
ComboBoxGadget(#cmbScreen, 10, 120, 200, 20, #PB_ComboBox_Editable) 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         Debug "EventType = " + Str(GadgetType(GadgetID))
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; Folding = -
; EnableXP