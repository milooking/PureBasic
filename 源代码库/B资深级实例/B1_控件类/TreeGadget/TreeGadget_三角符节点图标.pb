;***********************************
;迷路仟整理 2019.03.14
;TreeGadget_三角符节点图标
;***********************************

Enumeration
   #WinScreen
   #tvwScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "TreeGadget_三角符节点图标", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = TreeGadget(#tvwScreen, 010, 010, 380, 240) 

For a = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "节点 "+Str(a), 0, 0)
   AddGadgetItem(#tvwScreen, -1, "子项 1", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 4", 0, 1)
Next
SetWindowTheme_(hGadget, @"Explorer", 0)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; Folding = -
; EnableXP