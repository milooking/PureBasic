;***********************************
;迷路仟整理 2019.01.18
;删除列和行
;***********************************

Enumeration
   #WinScreen
   #lstScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "删除列和行", WindowFlags)
   ListIconGadget(#lstScreen,  010, 010, 380, 240, "列-1", 100, #PB_ListIcon_FullRowSelect)

   For Col = 2 To 4 
      AddGadgetColumn(#lstScreen, Col, "列-" + Str(Col), 65)
   Next
   For Row = 0 To 10
      AddGadgetItem(#lstScreen, Row, "子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row))
   Next
   RemoveGadgetColumn(#lstScreen, 1)
   RemoveGadgetItem(#lstScreen, 5)
   
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
; CursorPosition = 12
; Folding = -
; EnableXP