;***********************************
;迷路仟整理 2019.02.01
;MouseSimulateClick_鼠标模拟点击
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
   X*$FFFF/GetSystemMetrics_(#SM_CXSCREEN)
   Y*$FFFF/GetSystemMetrics_(#SM_CYSCREEN)
   mouse_event_(Event|#MOUSEEVENTF_ABSOLUTE, X, Y, 0, GetMessageExtraInfo_()) 
EndProcedure 

;移动鼠标
Event_MouseSimulate(#MOUSEEVENTF_MOVE|#MOUSEEVENTF_ABSOLUTE, 500, 100) 
;单击右键
Event_MouseSimulate(#MOUSEEVENTF_RIGHTDOWN|#MOUSEEVENTF_RIGHTUP) 

;双击左键
Event_MouseSimulate(#MOUSEEVENTF_MOVE|#MOUSEEVENTF_ABSOLUTE, 30, 30) 
Event_MouseSimulate(#MOUSEEVENTF_LEFTDOWN|#MOUSEEVENTF_LEFTUP) 
Event_MouseSimulate(#MOUSEEVENTF_LEFTDOWN|#MOUSEEVENTF_LEFTUP) 




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; FirstLine = 8
; Folding = -
; EnableXP
; EnableOnError