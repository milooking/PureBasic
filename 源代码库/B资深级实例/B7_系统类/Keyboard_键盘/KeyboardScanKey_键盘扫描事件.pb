;***********************************
;迷路仟整理 2019.02.01
;KeyboardScanKey_键盘扫描事件
;***********************************

Enumeration
   #winScreen
   #lblScreen
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "键盘扫描事件", WindowFlags)

TextGadget(#lblScreen, 130, 070, 140, 020, "")

KeyName$ = Space(256)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
      Case #WM_CHAR
         Debug "字符: " + Chr(EventwParam())
         SetGadgetText(#lblScreen, "当前有效输入字符: " + Chr(EventwParam()))
      Case #WM_KEYDOWN 
         Key = EventwParam()
         Virtual = MapVirtualKey_(Key,0)*$10000
         GetKeyNameText_(Virtual,KeyName$,255)
         Debug "Key = " + KeyName$ 
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP
; EnableOnError