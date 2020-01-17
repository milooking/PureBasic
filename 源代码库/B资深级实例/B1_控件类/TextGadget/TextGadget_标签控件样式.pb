;***********************************
;迷路仟整理 2019.03.28
;TextGadget_标签控件样式
;***********************************
Enumeration
   #winScreen 
   #lblScreen1
   #lblScreen2
   #lblScreen3
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"TextGadget_标签控件样式",WindowFlags) 

Flags = #ES_MULTILINE|#ES_AUTOVSCROLL|#ESB_DISABLE_LEFT|#ESB_DISABLE_RIGHT
hGadget = TextGadget(#lblScreen1, 100, 080, 200, 020, "Flat",     #PB_Text_Center | #PB_Text_Border) 
hGadget = TextGadget(#lblScreen2, 100, 110, 200, 020, "Flatter",  #PB_Text_Center | #SS_SUNKEN) 
hGadget = TextGadget(#lblScreen3, 100, 140, 200, 020, "Flattest", #PB_Text_Center | #WS_BORDER) 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; Folding = -
; EnableXP
; EnableUnicode