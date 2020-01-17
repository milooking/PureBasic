;***********************************
;迷路仟整理 2019.01.29
;三角函数
;***********************************

Debug "====== 【Cos】 ======"
Debug Cos(3.141593)  ;-1
Debug CosH(0)        ;1
Debug ACos(1)        ;0
Debug ACos(-1)       ;pi 
Debug ACosH(1)       ;0
Debug Exp(ACosH(0.5 * Sqr(5)))   ;1.6180339887498951



Debug "====== 【Sin】 ======"
Debug Sin(1.5708)          ;0.99999999999325373
Debug SinH(Log(1.618033))  ;0.49999931679051052
Debug ASin(1)              ;1.570796(#PI/2)
Debug ASin(0)              ;0
Debug ASinH(0)             ;0
Debug Exp(ASinH(0.5))      ;1.618033


Debug "====== 【Tan】 ======"
Debug Tan(0.785398)           ; 1'
Debug TanH(Log(1.618033))     ; 0.447213 (1/5 * Sqr(5))
Debug ATan(1)                 ; 0.785398 (#PI/4)
Debug ATan2(10, 10)           ; #PI/4
Debug Exp(ATanH(0.2 * Sqr(5))); 1.618033


Debug "====== 【Log】 ======"
Debug Log(10)        ;2.3025850929940459
Debug Log10(10)      ;1.0

Debug "====== 【Degree】 ======"
Debug Degree(#PI/4)  ;45
Debug Radian(90)     ;#PI/2

























; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 40
; FirstLine = 11
; EnableThread
; EnableXP