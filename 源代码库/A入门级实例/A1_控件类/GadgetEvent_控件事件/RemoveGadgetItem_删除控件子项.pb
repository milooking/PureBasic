;***********************************
;迷路仟整理 2019.01.21
;删除控件子项
;***********************************

Enumeration
   #winScreen
   #rtxScreen
   #btnScreen
EndEnumeration

;各种支持清空控件子项的控件
; ComboBoxGadget() 
; EditorGadget() 
; PanelGadget() 
; ListViewGadget() 
; ListIconGadget() 
; MDIGadget() 
; TreeGadget(),包括次级子项

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "删除控件子项", WindowFlags)

EditorGadget(#rtxScreen, 010, 10, 185, 230)                                        
ButtonGadget(#btnScreen, 210, 10, 110, 030, "删除第一行")    
                                    
For k = 0 To 10
   AddGadgetItem(#rtxScreen, -1, "文本行 "+Str(k)) 
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            RemoveGadgetItem(#rtxScreen, 0)
         EndIf 
   
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP