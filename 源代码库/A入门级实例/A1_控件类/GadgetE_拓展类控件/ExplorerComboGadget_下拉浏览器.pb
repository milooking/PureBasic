;***********************************
;迷路仟整理 2019.01.18
;下拉浏览器
;***********************************

Enumeration
   #WinScreen
   #fcxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "下拉浏览器", WindowFlags)

ExplorerComboGadget(#fcxScreen, 10, 10, 380, 25, GetHomeDirectory(), #PB_Explorer_Editable)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP