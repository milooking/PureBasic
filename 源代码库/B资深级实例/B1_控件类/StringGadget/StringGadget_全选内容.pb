;***********************************
;迷路仟整理 2019.03.28
;StringGadget_全选内容
;***********************************
Enumeration
   #winScreen 
   #txtScreen
EndEnumeration



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_全选内容",WindowFlags) 
hGadget = StringGadget(#txtScreen, 100, 100, 200, 022, "StringGadget_全选内容") 

SendMessage_(hGadget,#EM_SETSEL,0, -1)  
SetActiveGadget(#txtScreen)  

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; Folding = -
; EnableXP
; EnableUnicode