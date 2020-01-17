;***********************************
;迷路仟整理 2019.01.20
;复选框控件
;***********************************

Enumeration
   #winScreen
   #chkScreen1
   #chkScreen2
   #chkScreen3
   #chkScreen4
   #chkScreen5
   #chkScreen6
   #lblScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "复选框控件", WindowFlags)


CheckBoxGadget(#chkScreen1, 50, 010, 250, 20, "标准复选框")
CheckBoxGadget(#chkScreen2, 50, 040, 250, 20, "复选框-选中"): 
CheckBoxGadget(#chkScreen3, 50, 070, 250, 20, "复选框-第三态", #PB_CheckBox_ThreeState)
CheckBoxGadget(#chkScreen4, 50, 100, 250, 20, "复选框-右对齐", #PB_CheckBox_Right)
CheckBoxGadget(#chkScreen5, 50, 130, 250, 20, "复选框-居中",   #PB_CheckBox_Center)

SetGadgetState(#chkScreen1, #PB_Checkbox_Checked)
SetGadgetState(#chkScreen3, #PB_Checkbox_Inbetween)

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
; CursorPosition = 9
; Folding = -
; EnableXP