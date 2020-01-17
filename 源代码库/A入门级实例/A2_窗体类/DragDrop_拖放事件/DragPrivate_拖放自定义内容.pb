;***********************************
;迷路仟整理 2019.03.14
;DragPrivate_拖放内容
;***********************************

Enumeration
   #winScreen
   #lblScreen
   #lvwSource
   #lvwTarget1
   #lvwTarget2
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 410, 250, "DragPrivate_拖放内容:区分单双行", WindowFlags)
TextGadget(#lblScreen, 010, 010, 390, 015, "从左侧拖放源拖住内容往右侧释放.")
ListViewGadget(#lvwSource,  010, 030, 190, 210) 
ListViewGadget(#lvwTarget1, 210, 030, 190, 100)
ListViewGadget(#lvwTarget2, 210, 140, 190, 100)

For k = 1 To 16
   AddGadgetItem(#lvwSource, -1, "自定义内容-"+Str(k))
Next 
EnableGadgetDrop(#lvwTarget1, #PB_Drop_Private, #PB_Drag_Copy, 1)
EnableGadgetDrop(#lvwTarget2, #PB_Drop_Private, #PB_Drag_Copy, 2)
      
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      
      ;拖放源事件
      Case #PB_Event_Gadget
         If EventType() = #PB_EventType_DragStart
            Select EventGadget()
               Case #lvwSource
                  State = GetGadgetState(#lvwSource)
                  If State % 2 = 0
                     DragPrivate(1)
                  Else 
                     DragPrivate(2)
                  EndIf  
            EndSelect
         EndIf 
      
      ;拖放目标事件
      Case #PB_Event_GadgetDrop
         GadgetID = EventGadget()
         Select GadgetID
            Case #lvwTarget1
               State = GetGadgetState(#lvwSource)
               Text$ = GetGadgetItemText(#lvwSource, State)
               AddGadgetItem(#lvwTarget1, -1, "只支持单行: " + Text$)
            Case #lvwTarget2
               State = GetGadgetState(#lvwSource)
               Text$ = GetGadgetItemText(#lvwSource, State)
               AddGadgetItem(#lvwTarget2, -1, "只支持双行: " + Text$)                
                
         EndSelect

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; FirstLine = 13
; Folding = -
; EnableXP