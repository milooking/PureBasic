;***********************************
;迷路仟整理 2019.01.21
;设置/获取焦点控件
;***********************************

Enumeration
   #winScreen
   #btnScreen
   #chkScreen
   #ptnScreen
   #cmbScreen
   #txtScreen
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "设置/获取焦点控件", WindowFlags)

ButtonGadget  (#btnScreen, 10, 015, 200, 30, "激活文本框") 
CheckBoxGadget(#chkScreen, 10, 060, 200, 20, "复选框") 
OptionGadget  (#ptnScreen, 10, 090, 200, 20, "选项框") 
ComboBoxGadget(#cmbScreen, 10, 120, 200, 20, #PB_ComboBox_Editable) 
StringGadget  (#txtScreen, 10, 150, 200, 20, "") 

SetActiveGadget(#cmbScreen)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         If #btnScreen = GadgetID : SetActiveGadget(#txtScreen) : EndIf 
         SetWindowTitle(#winScreen, "获取焦点控件 - 当前焦点控件为: " + Str(GetActiveGadget()))
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; Folding = -
; EnableXP