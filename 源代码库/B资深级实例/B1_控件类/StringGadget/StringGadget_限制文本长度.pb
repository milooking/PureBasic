;***********************************
;迷路仟整理 2019.03.28
;StringGadget_限制文本长度
;***********************************
Enumeration
   #winScreen 
   #txtScreen
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_限制文本长度",WindowFlags) 

hGadget = StringGadget(#txtScreen, 100, 080, 200, 022, "") 
SendMessage_(hGadget, #EM_LIMITTEXT, 10, 0)


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