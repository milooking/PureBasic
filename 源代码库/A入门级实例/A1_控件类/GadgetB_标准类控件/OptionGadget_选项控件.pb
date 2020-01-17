;***********************************
;迷路仟整理 2019.01.20
;选项控件
;***********************************

Enumeration
   #winScreen
   #ptnScreen1
   #ptnScreen2
   #ptnScreen3
   #ptnScreen4
   #ptnScreen5
   #ptnScreen6
   #lblScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "选项控件", WindowFlags)
; 组1
OptionGadget(#ptnScreen1, 30, 20, 60, 20, "选项 11")
OptionGadget(#ptnScreen2, 30, 45, 60, 20, "选项 12")
OptionGadget(#ptnScreen3, 30, 70, 60, 20, "选项 13")
SetGadgetState(#ptnScreen1, 1) 
;分隔
TextGadget(#lblScreen,  150, 150, 100, 020, "") ;中间插入其它类型的控件,可以让Option分组
; 组2
OptionGadget(#ptnScreen4, 230, 20, 60, 20, "选项 21")
OptionGadget(#ptnScreen5, 230, 45, 60, 20, "选项 22")
OptionGadget(#ptnScreen6, 230, 70, 60, 20, "选项 23")
SetGadgetState(#ptnScreen5, 1) 

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
; CursorPosition = 25
; FirstLine = 15
; Folding = -
; EnableXP