;***********************************
;迷路仟整理 2019.01.28
;定义数据类型
;***********************************
;-
;- [Define]定义
; Define.<type> [<variable> [= <expression>], <variable> [= <expression>], ...]
Define.b a, b = 10, c = b*2, d 

; Define <variable>.<type> [= <expression>] [, <variable>.<type> [= <expression>], ...] 

Define MyChar.c 
Define MyLong.l 
Define MyWord.w 

Debug "结构大小: " + SizeOf(MyChar)   ; 显示 2
Debug "结构大小: " + SizeOf(MyLong)   ; 显示 4
Debug "结构大小: " + SizeOf(MyWord)   ; 显示 2


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP