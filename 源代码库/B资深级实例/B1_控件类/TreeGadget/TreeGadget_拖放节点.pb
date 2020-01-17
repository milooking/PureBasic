;***********************************
;迷路仟整理 2019.03.14
;TreeGadget_拖放节点
;***********************************

Enumeration
   #WinScreen
   #tvwScreen
EndEnumeration

Global _DragItem
Procedure DragStart_tvwScreen()
   _DragItem = GetGadgetState(#tvwScreen)
   DragPrivate(1, #PB_Drag_Move)
EndProcedure

Procedure GadgetDrop_tvwScreen()
   Text$ = GetGadgetItemText(#tvwScreen, _DragItem)
   RemoveGadgetItem(#tvwScreen, _DragItem)
   State = GetGadgetState(#tvwScreen)
   AddGadgetItem(#tvwScreen, State, Text$)
   Debug "源选项: " + Str(_DragItem) + " 插入的目标选项: " + Str(State)
   SetGadgetState(#tvwScreen, State)
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "TreeGadget_拖放节点", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = TreeGadget(#tvwScreen, 010, 010, 380, 240) 

EnableGadgetDrop(#tvwScreen, #PB_Drop_Private, #PB_Drag_Move, 1)
BindGadgetEvent(#tvwScreen, @DragStart_tvwScreen(), #PB_EventType_DragStart)
BindEvent(#PB_Event_GadgetDrop, @GadgetDrop_tvwScreen())

For a = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "节点-"+Str(a), 0, 0)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":1", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":4", 0, 1)
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; FirstLine = 6
; Folding = -
; EnableXP