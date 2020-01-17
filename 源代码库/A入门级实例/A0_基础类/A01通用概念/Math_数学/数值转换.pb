;***********************************
;迷路仟整理 2019.01.29
;数值转换
;***********************************

;【取圆周率】
Debug "====== 【取圆周率】 ======"
Debug #PI            ;3.1415926535897931

;【取整】
Debug "====== 【取整】 ======"
Debug Int(10.565)             ;10
Debug IntQ(12345678901.565)   ;12345678901

;【四舍五入】
Debug "====== 【四舍五入】 ======"
Debug Round(11.6, #PB_Round_Down)    ; '11'
Debug Round(-3.6, #PB_Round_Down)    ; '-4'

Debug Round(11.6, #PB_Round_Up)      ; '12'
Debug Round(-1.6, #PB_Round_Up)      ; '-1'

Debug Round(11.6, #PB_Round_Nearest) ; '12'
Debug Round(11.4, #PB_Round_Nearest) ; '11'
Debug Round(11.5, #PB_Round_Nearest) ; '12'
Debug Round(-7.5, #PB_Round_Nearest) ; '-8'

;【取余】
Debug "====== 【取余】 ======"
Debug 100 % 3        ;余数为:1
Debug 200 % 2        ;余数为:0 判断是否为单双数

;【取模】
Debug "====== 【取模】 ======"
Debug Mod(100, 3.5)  ;2.0

;【取绝对值】
Debug "====== 【取绝对值】 ======"
Debug Abs(3.14159)   ; '3.1415899999999999'
Debug Abs(-3.14159)  ; '3.1415899999999999'

;【取开方数】
Debug "====== 【取开方数】 ======"
Debug Sqr(3)          ;1.7320508075688772

;【取N次方数】
Debug "====== 【取N次方数】 ======"
Debug Pow(3, 2)        ;3的平方: 9.0
Debug Pow(3, 1/2)      ;3的平方根: 1.7320508075688772
Debug Pow(3, 20)       ;3的20次: 3486784401.0
Debug Pow(1000, 1/10)  ;1000的10次平方根: 1.9952623149688797


;【取数值符号】即+-号
Debug "====== 【取数值符号】 ======"
Debug Sign(-7)    ;-1.0
Debug Sign(0)     ;0.0
Debug Sign(7)     ;1.0


;【判断数值有效性】
Debug NaN()                  ;非数值数
Debug Infinity()             ;无穷数
Debug IsNAN(NaN() * 5 + 2)   ; 1
Result = IsNAN(NaN())         ; NaN
Result = IsNAN(Sqr(-1))       ; NaN
Result = IsNAN(1234.5)        ; 正常数
Result = IsNAN(Infinity())    ; 无穷数 不是 NaN 








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 58
; FirstLine = 43
; EnableThread
; EnableXP