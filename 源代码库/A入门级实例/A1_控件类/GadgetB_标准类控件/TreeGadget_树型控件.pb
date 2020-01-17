;***********************************
;迷路仟整理 2019.01.20
;树型控件
;***********************************

Enumeration
   #winScreen
   #tvwScreen1
   #tvwScreen2
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "树型控件", WindowFlags)

TreeGadget(#tvwScreen1, 010, 10, 185, 230)                                        
TreeGadget(#tvwScreen2, 205, 10, 185, 230, #PB_Tree_CheckBoxes | #PB_Tree_NoLines) 
hImage = LoadImage(#imgScreen, "PureBasic.ico")
For GadgetID = #tvwScreen1 To #tvwScreen2
   For k = 0 To 10
      AddGadgetItem(GadgetID, -1, "正常节点"+Str(k), 0, 0) 
      AddGadgetItem(GadgetID, -1, "父节点 "+Str(k), 0, 0)      
      AddGadgetItem(GadgetID, -1, "子节点 1", 0, 1)   
      AddGadgetItem(GadgetID, -1, "子节点 2", 0, 1)
      AddGadgetItem(GadgetID, -1, "子节点 3", 0, 1)
      AddGadgetItem(GadgetID, -1, "子节点 4", 0, 1)
      AddGadgetItem(GadgetID, -1, "文件 "+Str(k), hImage) 
   Next
Next


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
; CursorPosition = 15
; Folding = -
; EnableXP