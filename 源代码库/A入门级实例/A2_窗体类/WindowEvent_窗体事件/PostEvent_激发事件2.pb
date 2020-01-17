;***********************************
;迷路仟整理 2019.01.21
;激发事件2
;***********************************

Enumeration 
   #winScreen
   #lstScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "激发事件2", WindowFlags)

ListIconGadget(#lstScreen,  010, 010, 380, 180, "列-1", 400-45-120, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_CheckBoxes)
For Col = 2 To 4 
   AddGadgetColumn(#lstScreen, Col, "列-" + Str(Col), 60)
Next
For Row = 0 To 10
   AddGadgetItem(#lstScreen, Row, "子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row))
Next

SetGadgetState(#lstScreen, 5)

ButtonGadget(#btnScreen1, 010, 200, 100, 040, "左键单击事件")
ButtonGadget(#btnScreen2, 150, 200, 100, 040, "左键双击事件")
ButtonGadget(#btnScreen3, 280, 200, 100, 040, "右键单击事件")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         Select EventGadget() 
            Case #btnScreen1 : PostEvent(#PB_Event_Gadget, #winScreen, #lstScreen, #PB_EventType_LeftClick)
            Case #btnScreen2 : PostEvent(#PB_Event_Gadget, #winScreen, #lstScreen, #PB_EventType_LeftDoubleClick)
            Case #btnScreen3 : PostEvent(#PB_Event_Gadget, #winScreen, #lstScreen, #PB_EventType_RightClick)
            Case #lstScreen 
               Select EventType()
                  Case #PB_EventType_LeftClick        : Debug "左键单击事件"
                  Case #PB_EventType_LeftDoubleClick  : Debug "左键双击事件"
                  Case #PB_EventType_RightClick       : Debug "右键单击事件"
               EndSelect    
         EndSelect
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP