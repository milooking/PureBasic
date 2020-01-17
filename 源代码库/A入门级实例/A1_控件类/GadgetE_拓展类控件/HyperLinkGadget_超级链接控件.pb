;***********************************
;迷路仟整理 2019.01.18
;超级链接控件
;***********************************

Enumeration
   #WinScreen
   #hlkScreen1
   #hlkScreen2
   #fntScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "超级链接控件", WindowFlags)

hFont = LoadFont(#fntScreen, "Arial", 12)
HyperLinkGadget(#hlkScreen1, 10, 10, 250,20,"红色链接", RGB(255,0,0))
HyperLinkGadget(#hlkScreen2, 10, 30, 250,20,"下划线绿色链接", RGB(0,180,0), #PB_HyperLink_Underline)
SetGadgetFont  (#hlkScreen2, hFont)
SetGadgetColor (#hlkScreen1, #PB_Gadget_FrontColor, RGB(0,125,255))

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
; CursorPosition = 17
; Folding = -
; EnableXP