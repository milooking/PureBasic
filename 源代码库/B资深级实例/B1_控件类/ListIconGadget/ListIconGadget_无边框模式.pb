;***********************************
;迷路仟整理 2019.01.20
;ListIconGadget_无边框模式
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_无边框模式",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect|#PB_ListIcon_GridLines) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)

   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next

   Style = GetWindowLong_(hGadget, #GWL_EXSTYLE) &(~#WS_EX_CLIENTEDGE)
   SetWindowLong_(hGadget, #GWL_EXSTYLE, Style)  
   SetWindowPos_(hGadget, 0, 0, 0, 0, 0, #SWP_SHOWWINDOW | #SWP_NOZORDER | #SWP_NOSIZE | #SWP_NOMOVE | #SWP_FRAMECHANGED)  

   Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; Folding = -
; EnableXP
; EnableUnicode