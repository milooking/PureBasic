;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_自适应列宽
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_自适应列宽",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_CheckBoxes) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项xxxxxxxxx-" + Str(i)+#LF$+"子项yy-" + Str(i))
   Next
   For i= 0 To 2  
      SendMessage_(hGadget, #LVM_SETCOLUMNWIDTH, i, #LVSCW_AUTOSIZE_USEHEADER)  
   Next  
      
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; FirstLine = 1
; Folding = -
; EnableXP
; EnableUnicode