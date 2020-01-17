;***********************************
;迷路仟整理 2019.03.28
;StringGadget_限制文本长度
;***********************************
Enumeration
   #winScreen 
   #txtScreen
   #btnScreen
EndEnumeration

Procedure EventGadget_txtScreen()
   Locked = GetGadgetState(#btnScreen)
   SendMessage_(GadgetID(#txtScreen),#EM_SETREADONLY,locked,0)  
EndProcedure


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_限制文本长度",WindowFlags) 

ButtonGadget(#btnScreen, 100, 120, 200, 030, "只读", #PB_Button_Toggle) 
StringGadget(#txtScreen, 100, 050, 200, 022, "") 

BindGadgetEvent(#btnScreen, @EventGadget_txtScreen())


Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; Folding = -
; EnableXP
; EnableUnicode