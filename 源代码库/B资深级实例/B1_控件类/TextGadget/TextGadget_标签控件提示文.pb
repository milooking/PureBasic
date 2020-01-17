;***********************************
;迷路仟整理 2019.03.28
;TextGadget_标签控件提示文
;***********************************
Enumeration
   #winScreen 
   #lblScreen
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"TextGadget_标签控件提示文",WindowFlags) 

Flags = #ES_MULTILINE|#ES_AUTOVSCROLL|#ESB_DISABLE_LEFT|#ESB_DISABLE_RIGHT
hGadget = TextGadget(#lblScreen, 100, 080, 200, 020, "标签控件也可以有提示文",  #SS_NOTIFY) 
GadgetToolTip(#lblScreen, "TextGadget_标签控件提示文")  

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP
; EnableUnicode