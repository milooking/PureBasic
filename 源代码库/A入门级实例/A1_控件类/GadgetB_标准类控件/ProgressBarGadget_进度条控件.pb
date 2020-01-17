;***********************************
;迷路仟整理 2019.01.20
;分页控件
;***********************************

Enumeration
   #winScreen
   #prgScreen1
   #prgScreen2
   #prgScreen3
   #lblScreen1
   #lblScreen2
   #lblScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 440, 200, "进度条控件", WindowFlags)

TextGadget       (#lblScreen1,  010, 010, 350, 020, "标准进度条  (50/100)", #PB_Text_Center)
ProgressBarGadget(#prgScreen1,  010, 030, 350, 020, 0, 100)
SetGadgetState   (#prgScreen1,  050)  
TextGadget       (#lblScreen2,  010, 070, 350, 020, "进度条光滑样式(50/200)", #PB_Text_Center)
ProgressBarGadget(#prgScreen2,  010, 090, 350, 020, 0, 200, #PB_ProgressBar_Smooth)
SetGadgetState   (#prgScreen2,  050)
TextGadget       (#lblScreen3,  200, 135, 200, 020, "进度条垂直样式 (100/300)", #PB_Text_Right)
ProgressBarGadget(#prgScreen3,  370, 010, 020, 120, 0, 300, #PB_ProgressBar_Vertical)
SetGadgetState   (#prgScreen3,  100)  

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
; CursorPosition = 16
; Folding = -
; EnableXP