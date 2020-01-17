;***********************************
;迷路仟整理 2019.03.28
;StringGadget_回车功能
;***********************************
Enumeration
   #winScreen 
   #txtScreen1
   #txtScreen2
EndEnumeration

Procedure EventGadget_txtScreen()

EndProcedure


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,400,250,"StringGadget_回车功能",WindowFlags) 

hGadget1 = StringGadget(#txtScreen1, 100, 050, 200, 022, "") 
hGadget2 = StringGadget(#txtScreen2, 100, 090, 200, 022, "") 

BindGadgetEvent(#txtScreen1, @EventGadget_txtScreen())
AddKeyboardShortcut(#winScreen, #PB_Shortcut_Return,111)  

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu  
         If EventMenu() = 111
            If GetFocus_() = hGadget1  
               SetFocus_(hGadget2) 
            Else 
               SetFocus_(hGadget1) 
            EndIf 
         EndIf 
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP
; EnableUnicode