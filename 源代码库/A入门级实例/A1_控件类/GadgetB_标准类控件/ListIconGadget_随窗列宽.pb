;***********************************
;迷路仟整理 2019.01.18
;随窗列宽
;***********************************

Enumeration
   #WinScreen
   #lstScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "随窗列宽", WindowFlags)
   ListIconGadget(#lstScreen,  010, 010, 380, 230, "列-1", 400-45-120, #PB_ListIcon_FullRowSelect)

   For Col = 2 To 4 
      AddGadgetColumn(#lstScreen, Col, "列-" + Str(Col), 60)
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
      Case #PB_Event_SizeWindow
         W = WindowWidth (#WinScreen) - 20
         H = WindowHeight(#WinScreen) - 20
         ResizeGadget(#lstScreen, #PB_Ignore, #PB_Ignore, W, H)
         For k = 1 To GetGadgetAttribute(#lstScreen, #PB_ListIcon_ColumnCount)
            W-GetGadgetItemAttribute(#lstScreen, 0, #PB_ListIcon_ColumnWidth, k)
         Next 
         SetGadgetItemAttribute(#lstScreen, 0, #PB_ListIcon_ColumnWidth, W-25)
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP