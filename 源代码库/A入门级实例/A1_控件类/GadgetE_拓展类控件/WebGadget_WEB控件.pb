;***********************************
;迷路仟整理 2019.01.20
;WEB控件
;***********************************

Enumeration
   #winScreen
   #wbsScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "WEB控件", WindowFlags)

WebGadget(#wbsScreen, 10, 10, 380, 230, "https://www.baidu.com")

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
; CursorPosition = 13
; Folding = -
; EnableXP