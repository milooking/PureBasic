;***********************************
;迷路仟整理 2019.01.17
;下拉控件
;***********************************

Enumeration
   #WinScreen
   #cmbScreen1
   #cmbScreen2
   #cmbScreen3
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "下拉控件", WindowFlags)

hImage = LoadImage(#imgScreen, "PureBasic.ico")

;标准下拉控件
ComboBoxGadget(#cmbScreen1, 150, 050, 100, 20) 
For k = 1 To 10 : AddGadgetItem(#cmbScreen1, -1, "子项-"+Str(k)) : Next 
SetGadgetState(#cmbScreen1, 0)

;可编辑下拉控件
ComboBoxGadget(#cmbScreen2, 150, 080, 100, 20, #PB_ComboBox_Editable)
For k = 1 To 10 : AddGadgetItem(#cmbScreen2, -1, "子项-"+Str(k)) : Next 
SetGadgetText(#cmbScreen2, "可自由编辑")

;带图标下拉控件
ComboBoxGadget(#cmbScreen3, 150, 110, 100, 20, #PB_ComboBox_Image)
For k = 1 To 10 : AddGadgetItem(#cmbScreen3, -1, "子项-"+Str(k), hImage) : Next 
SetGadgetState(#cmbScreen3, 0)

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
; CursorPosition = 31
; Folding = -
; EnableXP