;***********************************
;迷路仟整理 2019.01.26
;MousetWheel_鼠标中轮事件
;***********************************

; #MOUSEEVENTF_MOVE        = $1 
; #MOUSEEVENTF_ABSOLUTE    = $8000 
; #MOUSEEVENTF_LEFTDOWN    = $2 
; #MOUSEEVENTF_LEFTUP      = $4 
; #MOUSEEVENTF_MIDDLEDOWN  = $20 
; #MOUSEEVENTF_MIDDLEUP    = $40 
; #MOUSEEVENTF_RIGHTDOWN   = $8 
; #MOUSEEVENTF_RIGHTUP     = $10 

Procedure Event_MouseSimulate(Event.l, X=0, Y=0) 
   GetCursorPos_(Point.POINT) 
   If X = 0 : X = Point\x : EndIf 
   If Y = 0 : Y = Point\y : EndIf 
   mouse_event_(Event|#MOUSEEVENTF_ABSOLUTE, X, Y, 0, GetMessageExtraInfo_()) 
EndProcedure 




#winScreen = 0
#lblScreen = 0

; WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
;               #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
;        
; hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标中轮事件", WindowFlags)
; TextGadget(#lblScreen, 130, 100, 140, 060, "")

Event_MouseSimulate(#MOUSEEVENTF_MOVE, 200, 200) 

; Event_MouseSimulate(#MOUSEEVENTF_RIGHTDOWN) 
; Event_MouseSimulate(#MOUSEEVENTF_RIGHTUP) 


; Repeat
;    WinEvent  = WindowEvent()
;    Select WinEvent
;       Case #PB_Event_CloseWindow : IsExitWindow = #True
;       Case #WM_MBUTTONDBLCLK
;    EndSelect
;    Delay(1)
; Until IsExitWindow = #True
; 
; End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; FirstLine = 19
; Folding = -
; EnableXP
; EnableOnError