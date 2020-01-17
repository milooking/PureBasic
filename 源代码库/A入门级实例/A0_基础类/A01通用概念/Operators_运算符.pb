;***********************************
;迷路仟整理 2019.01.29
;Operators_运算符
;***********************************


;【运算符缩写】
  Value + 1    ; 相同于 Value = Value + 1
  Value * 2    ; 相同于 Value = Value * 2
  Value << 1   ; 相同于 Value = Value << 1
  Value$ + "A" ; 相同于 Value$ = Value$ + "A"

  Dim DimArray(10)
  DimArray(1) + 1 ; 相同于 DimArray(1) = DimArray(1) + 1


;【运算符优先等级】
;   等级 |        运算符
;   -----+---------------------------
;   8(高)|         ~, - (负号)
;   7    |      <<, >>, %, !
;   6    |         |, &
;   5    |         *, /
;   4    |         +, - (减号)
;   3    | >, >=, =>, <, <=, =<, =, <>
;   2    |          Not
;   1(低)|      And, Or, XOr


;【运算符】
; 〖算术运算符〗 =,+, -, *, /, %
; 〖位 运 算符〗 &, |, !, ~, <<, >>
; 〖比较运算符〗 >, >=, =>, <, <=, =<, =, <>
; 〖逻辑运算符〗 And, Or, XOr, Not

; << 左移,相当于x2
; >> 右移,相当于/2取整
; %  取余

;  0 & 0 = 0      0 | 0 = 0      0 ! 0 = 0      ~0 = 1
;  0 & 1 = 0      0 | 1 = 1      0 ! 1 = 1      ~1 = 0
;  1 & 0 = 0      1 | 0 = 1      1 ! 0 = 1
;  1 & 1 = 1      1 | 1 = 1      1 ! 1 = 0

;  F And F = F      F Or F = F      F XOr F = F      Not F = T
;  F And T = F      F Or T = T      F XOr T = T      Not T = F
;  T And F = F      T Or F = T      T XOr F = T
;  T And T = T      T Or T = T      T XOr T = F


;【布尔运算】
;  Bool()
  Hello$ = "Hello"
  World$ = "World"
  Debug Bool(Hello$ = "Hello") 
  Debug Bool(Hello$ <> "Hello" Or World$ = "World") 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 39
; FirstLine = 22
; EnableXP