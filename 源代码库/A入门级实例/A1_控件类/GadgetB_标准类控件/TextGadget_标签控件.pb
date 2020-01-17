;***********************************
;迷路仟整理 2019.01.20
;标签控件
;***********************************

Enumeration
   #winScreen
   #lblScreen1
   #lblScreen2
   #lblScreen3
   #lblScreen4
   #lblScreen5
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "标签控件", WindowFlags)


TextGadget(#lblScreen1, 010, 010, 380, 020, "标准标签控件")
TextGadget(#lblScreen2, 010, 070, 380, 020, "居中样式", #PB_Text_Center)
TextGadget(#lblScreen3, 010, 040, 380, 020, "右对齐样式", #PB_Text_Right)
TextGadget(#lblScreen4, 010, 100, 380, 020, "带边框样式", #PB_Text_Border)
TextGadget(#lblScreen5, 010, 130, 380, 020, "居中+带边框", #PB_Text_Center | #PB_Text_Border)

SetGadgetColor(#lblScreen2, #PB_Gadget_BackColor, RGB(255,255,225))
SetGadgetColor(#lblScreen4, #PB_Gadget_FrontColor, RGB(255,0,0))

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
; CursorPosition = 5
; FirstLine = 1
; Folding = -
; EnableXP