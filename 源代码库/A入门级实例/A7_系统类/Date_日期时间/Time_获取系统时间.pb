;***********************************
;迷路仟整理 2019.03.15
;Time_获取毫秒级时间
;***********************************


TickTime.q = GetTickCount_()

TickTime = TickTime % 1000

DateTime = Date()
Debug Str(TickTime)+"毫秒"
Debug FormatDate("%YYYY-%MM-%DD %HH:%II:%SS.", DateTime)  + RSet(Str(TickTime), 3, "0")








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; EnableXP