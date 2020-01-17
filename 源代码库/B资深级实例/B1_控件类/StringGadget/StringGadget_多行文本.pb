;***********************************
;迷路仟整理 2019.03.28
;StringGadget_多行文本
;***********************************
Enumeration
   #winScreen 
   #txtScreen
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_多行文本",WindowFlags) 

Text$ = "这里显示的效果为多行文本:" + #CRLF$ + "StringGadget_多行文本"
hGadget = StringGadget(#txtScreen, 100, 080, 200, 080, Text$, #ES_MULTILINE|#WS_HSCROLL) 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; Folding = -
; EnableXP
; EnableUnicode