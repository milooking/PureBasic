;***********************************
;迷路仟整理 2019.03.14
;DragText_拖放文本
;***********************************

Enumeration
   #winScreen
   #lblScreen
   #lvwSource
   #lvwTarget
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 410, 250, "DragText_拖放文本", WindowFlags)
TextGadget(#lblScreen, 010, 010, 390, 015, "从左侧拖放源拖住文本往右侧释放.")
ListViewGadget(#lvwSource, 010, 035, 190, 200) 
ListViewGadget(#lvwTarget, 210, 035, 190, 200)

AddGadgetItem(#lvwSource, -1, "清明时节雨纷纷")
AddGadgetItem(#lvwSource, -1, "路上行人欲断魂")
AddGadgetItem(#lvwSource, -1, "借问酒家何处有")
AddGadgetItem(#lvwSource, -1, "牧童遥指杏花村")
AddGadgetItem(#lvwSource, -1, "离离原上草")
AddGadgetItem(#lvwSource, -1, "一岁一枯荣")
AddGadgetItem(#lvwSource, -1, "野火烧不尽")
AddGadgetItem(#lvwSource, -1, "春风吹又生")
AddGadgetItem(#lvwSource, -1, "远芳侵古道")
AddGadgetItem(#lvwSource, -1, "晴翠接荒城")
AddGadgetItem(#lvwSource, -1, "又送王孙去")
AddGadgetItem(#lvwSource, -1, "萋萋满别情")

EnableGadgetDrop(#lvwTarget, #PB_Drop_Text, #PB_Drag_Copy)
      
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
                  Text$ = GetGadgetItemText(#lvwSource, State)
                  DragText(Text$)
            EndSelect
         EndIf 
      
      ;拖放目标事件
      Case #PB_Event_GadgetDrop
         GadgetID = EventGadget()
         Select GadgetID
            Case #lvwTarget
               Text$ = EventDropText()
               AddGadgetItem(#lvwTarget, -1, Text$)
         EndSelect

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; FirstLine = 1
; Folding = -
; EnableXP