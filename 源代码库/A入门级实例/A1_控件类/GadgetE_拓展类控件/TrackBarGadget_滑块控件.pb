;***********************************
;迷路仟整理 2019.01.20
;滑片控件
;***********************************

Enumeration
   #winScreen
   #tkbScreen1
   #tkbScreen2
   #tkbScreen3
   #lblScreen1
   #lblScreen2
   #lblScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 420, 250, "滑片控件", WindowFlags)

TextGadget    (#lblScreen1, 010, 020, 350, 020,"标准滑片控件", #PB_Text_Center)
TrackBarGadget(#tkbScreen1, 010, 040, 350, 030, 0, 10000)
SetGadgetState(#tkbScreen1, 5000)

TextGadget    (#lblScreen2, 010, 100, 350, 020, "刻度样式", #PB_Text_Center)
TrackBarGadget(#tkbScreen2, 010, 120, 350, 030, 0, 30, #PB_TrackBar_Ticks)
SetGadgetState(#tkbScreen2, 3000)

TextGadget    (#lblScreen3, 190, 180, 200, 020, "垂直模式", #PB_Text_Right)
TrackBarGadget(#tkbScreen3, 370, 010, 030, 170, 0, 10000, #PB_TrackBar_Vertical)
SetGadgetState(#tkbScreen3, 8000)


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
; Folding = -
; EnableXP