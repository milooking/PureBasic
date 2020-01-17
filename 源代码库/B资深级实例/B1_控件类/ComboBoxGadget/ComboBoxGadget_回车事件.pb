;***********************************
;迷路仟整理 2019.01.17
;回车事件
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "回车事件", WindowFlags)


hGadget = ComboBoxGadget(#cmbScreen, 150, 050, 100, 20, #PB_ComboBox_Editable) 
For k = 1 To 10 
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(k)) 
Next 
SetGadgetState(#cmbScreen, 0)
  
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Select EventType()  
            Case #PB_EventType_Change : Debug "修改中"
         EndSelect 
      Case #WM_KEYFIRST
         Select EventwParam()  
            Case #VK_RETURN : Debug "回车键"
         EndSelect 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; FirstLine = 2
; Folding = -
; EnableXP