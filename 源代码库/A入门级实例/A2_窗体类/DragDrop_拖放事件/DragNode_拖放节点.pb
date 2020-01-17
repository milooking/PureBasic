;***********************************
;迷路仟整理 2019.03.14
;TreeGadget_拖放节点
;***********************************

Enumeration
   #WinScreen
   #tvwScreen
EndEnumeration

Global _DragItem


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "TreeGadget_拖放节点", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = TreeGadget(#tvwScreen, 010, 010, 380, 240) 

For a = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "节点-"+Str(a), 0, 0)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":1", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项-"+Str(a)+":4", 0, 1)
Next

EnableGadgetDrop(#tvwScreen, #PB_Drop_Text, #PB_Drag_Copy)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      ;拖放源事件
      Case #PB_Event_Gadget
         If EventType() = #PB_EventType_DragStart
            Select EventGadget()
               Case #tvwScreen
                  _DragItem = GetGadgetState(#tvwScreen)
                  Text$ = GetGadgetItemText(#tvwScreen, _DragItem)
                  DragText(Text$)
            EndSelect
         EndIf 
      
      ;拖放目标事件
      Case #PB_Event_GadgetDrop
         GadgetID = EventGadget()
         Select GadgetID
            Case #tvwScreen
               RemoveGadgetItem(#tvwScreen, _DragItem)
               State = GetGadgetState(#tvwScreen)
               Text$ = EventDropText()
               AddGadgetItem(#tvwScreen, State, Text$)
               SetGadgetState(#tvwScreen, State)
         EndSelect
      
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; FirstLine = 18
; Folding = -
; EnableXP