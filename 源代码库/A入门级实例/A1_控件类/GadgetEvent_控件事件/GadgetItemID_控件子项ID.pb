;***********************************
;迷路仟整理 2019.01.21
;控件子项ID
;***********************************

Enumeration
   #winScreen
   #tvwScreen
   #lvwScreen
EndEnumeration

; GadgetItemID() : 当前版本只支持TreeGadget()

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "控件子项ID", WindowFlags)

TreeGadget(#tvwScreen, 010, 10, 185, 230)                                        
For k = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "正常节点"+Str(k), 0, 0) 
   AddGadgetItem(#tvwScreen, -1, "父节点 "+Str(k), 0, 0)      
   AddGadgetItem(#tvwScreen, -1, "子节点 1", 0, 1)   
   AddGadgetItem(#tvwScreen, -1, "子节点 2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 4", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "文件 "+Str(k), hImage) 
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         State = GetGadgetState(GadgetID)
         Debug "GadgetItemID = " + Str(GadgetItemID(GadgetID, State))
   
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; FirstLine = 4
; Folding = -
; EnableXP