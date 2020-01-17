;***********************************
;迷路仟整理 2019.01.20
;ListViewGadget_无边框模式
;***********************************
Enumeration
   #winScreen 
   #lvwScreen
EndEnumeration

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"ListViewGadget_无边框模式",WindowFlags) 

   hGadget = ListViewGadget(#lvwScreen,010,010,380,230) 
   For i = 1 To 10
      AddGadgetItem (#lvwScreen, -1, "子项-" + Str(i))
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
; CursorPosition = 20
; FirstLine = 4
; Folding = -
; EnableXP
; EnableUnicode