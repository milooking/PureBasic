;***********************************
;迷路仟整理 2019.03.28
;StringGadget_自动换行
;***********************************
Enumeration
   #winScreen 
   #txtScreen
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_自动换行",WindowFlags) 

Text$ = "这里显示的自动换行的效果: 后面的内容很长很长很长很长很长很长很长很长很长很长长...."
Flags = #ES_MULTILINE|#ES_AUTOVSCROLL|#ESB_DISABLE_LEFT|#ESB_DISABLE_RIGHT
hGadget = StringGadget(#txtScreen, 100, 080, 200, 080, Text$, Flags) 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP
; EnableUnicode