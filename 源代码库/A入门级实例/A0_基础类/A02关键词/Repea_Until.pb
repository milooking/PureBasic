;***********************************
;迷路仟整理 2019.01.28
;Repeat_Until Repeat循环
;***********************************

; Repeat
;   ...
; Until <expression> [Or ForEver] 

;Repeat循环,有两种形式: Repeat:ForEver 和 Repeat:Until
;[Repeat:ForEver]无条件循环,是死循环,退出方法是中间加Break
;[Repeat:Until]有条件循环,Until是退出条件,满足Until则不再循环
;Repeat不建议用于List和Map的历遍

;【Repeat:ForEver】
a=0
Repeat 
   a=a+1
   If a > 100 : Break : EndIf 
ForEver
Debug a
   
   
;【Repeat:Until】 ;这种形式比较常用
a=0
Repeat 
   a=a+1
Until a > 100 
Debug a



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; FirstLine = 6
; EnableXP