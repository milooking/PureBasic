;***********************************
;迷路仟整理 2019.01.17
;日期控件
;***********************************

Enumeration
   #WinScreen
   #dtgbScreen1
   #dtgbScreen2
   #dtgbScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "日期控件", WindowFlags)

;注: 秒不起作用,大写不起作用.
DateGadget(#dtgbScreen1, 070, 050, 260, 25, "日期: %yyyy-%mm-%dd 时间: %hh:%ii") 
DateGadget(#dtgbScreen2, 070, 080, 260, 25, "日期: %yyyy-%mm-%dd 时间: %hh:%ii:%ss") 
DateGadget(#dtgbScreen3, 070, 110, 260, 25, "日期: %YYYY-%MM-%DD 时间: %HH:%II:%SS") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug EventGadget()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; Folding = -
; EnableXP