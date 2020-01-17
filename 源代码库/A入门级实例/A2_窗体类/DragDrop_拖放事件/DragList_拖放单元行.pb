;***********************************
;迷路仟整理 2016.03.14
;DragList_拖放单元行
;***********************************

Enumeration
   #WinScreen
   #lstScreen
EndEnumeration

Global _DragItem


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "DragList_拖放单元行", WindowFlags)

GadgetFlags = #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = ListIconGadget(#lstScreen,010,010,380, 240, "文件名", 245, GadgetFlags) 

For i = 0 To 30
   AddGadgetItem(#lstScreen, -1, "子项-"+Str(i), 0, 0)
Next

EnableGadgetDrop(#lstScreen, #PB_Drop_Text, #PB_Drag_Copy)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      ;拖放源事件
      Case #PB_Event_Gadget
         If EventType() = #PB_EventType_DragStart
            Select EventGadget()
               Case #lstScreen
                  _DragItem = GetGadgetState(#lstScreen)
                  Text$ = GetGadgetItemText(#lstScreen, _DragItem)
                  DragText(Text$)
            EndSelect
         EndIf 
      
      ;拖放目标事件
      Case #PB_Event_GadgetDrop
         GadgetID = EventGadget()
         Select GadgetID
            Case #lstScreen
               RemoveGadgetItem(#lstScreen, _DragItem)
               State = GetGadgetState(#lstScreen)
               Text$ = EventDropText()
               AddGadgetItem(#lstScreen, State, Text$)
               SetGadgetState(#lstScreen, State)
         EndSelect
      
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 39
; FirstLine = 24
; Folding = -
; EnableXP
; EnableUnicode