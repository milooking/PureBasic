;***********************************
;迷路仟整理 2019.01.20
;滚动条控件
;***********************************

Enumeration
   #winScreen
   #scbScreen1
   #scbScreen2
   #lblScreen1
   #lblScreen2
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 440, 250, "滚动条控件", WindowFlags)

TextGadget       (#lblScreen1, 010, 025, 350, 020, "水平滚动条 (30/100)",#PB_Text_Center)
ScrollBarGadget  (#scbScreen1, 010, 042, 350, 020, 0, 100, 30)
SetGadgetState   (#scbScreen1, 050)

TextGadget       (#lblScreen2, 110, 115, 250, 020, "垂直滚动条  (50/300)",#PB_Text_Right)
ScrollBarGadget  (#scbScreen2, 370, 010, 020, 120 ,0, 300, 50, #PB_ScrollBar_Vertical)
SetGadgetState   (#scbScreen2, 100)

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
; CursorPosition = 26
; Folding = -
; EnableXP