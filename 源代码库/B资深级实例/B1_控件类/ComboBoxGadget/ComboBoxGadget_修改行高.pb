;***********************************
;迷路仟整理 2019.01.17
;下拉控件修改行高
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "下拉控件修改行高", WindowFlags)


hGadget = ComboBoxGadget(#cmbScreen, 150, 050, 100, 20) 
For k = 1 To 10 
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(k)) 
Next 
SetGadgetState(#cmbScreen, 0)

SendMessage_(hGadget, #CB_SETITEMHEIGHT, 00, 20)  
  
  
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
; CursorPosition = 34
; FirstLine = 1
; Folding = -
; EnableXP