;***********************************
;迷路仟整理 2019.01.17
;下拉控件修改行高
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
   #txtScreen
EndEnumeration

Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Select uMsg 
      Case #WM_COMMAND 
         If lParam = GadgetID(#cmbScreen)  
            Select wParam>>16 
               Case #CBN_KILLFOCUS 
                  Debug "下拉控件失去焦点"  
               Case #CBN_SETFOCUS 
                  Debug "下拉控件获得焦点"  
            EndSelect 
         EndIf 
   EndSelect  
   ProcedureReturn Result  
EndProcedure  


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "下拉控件修改行高", WindowFlags)

SetWindowCallback(@Window_Callback())

StringGadget  (#txtScreen, 150, 050, 100, 20, "") 
ComboBoxGadget(#cmbScreen, 150, 080, 100, 20, #PB_ComboBox_Editable) 

For k = 1 To 10 
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(k)) 
Next 
SetGadgetState(#cmbScreen, 0)
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; FirstLine = 1
; Folding = -
; EnableXP