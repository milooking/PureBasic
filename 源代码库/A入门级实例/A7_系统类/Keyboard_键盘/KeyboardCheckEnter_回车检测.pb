;***********************************
;迷路仟整理 2019.02.01
;KeyboardCheckEnter_回车检测
;***********************************

Enumeration
   #winScreen
   #txtScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 000, 000, 400, 250, "回车检测", WindowFlags)
StringGadget(#txtScreen, 130, 070, 140, 020, "")

KeyName$ = Space(256)

Repeat
   WinEvent = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
      Case #WM_CHAR
         If EventwParam() = #VK_RETURN
            Debug "OK"
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP
; EnableOnError