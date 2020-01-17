;***********************************
;迷路仟整理 2019.01.25
;获系统时间
;***********************************


Result.q = ElapsedMilliseconds()   ;获取当前时间
Delay(1000)  ;设置延时时间
Debug Str(ElapsedMilliseconds()-Result) + "ms"

Result = DoubleClickTime()

Debug  "鼠标双击时间间隔: " + Result + "ms"





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP