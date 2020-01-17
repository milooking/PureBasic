;***********************************
;迷路仟整理 2019.01.28
;Select_EndSelect 分支选择(判断)
;***********************************

; Select <expression1>
;   Case <expression> [, <expression> [<numeric expression> To <numeric expression>]]
;      ...
;   [Case <expression>]
;      ...
;   [Default] :其它条件
;      ...
; EndSelect 

;Case 支持多条件,用逗号隔开,还支持To形式,如: 1 To 10

;【简单实例】
   Value = 2
   Select Value
      Case 1 : Debug "Value = A"
      Case 2 : Debug "Value = B"
      Case 3 : Debug "Value = C"
      Case 4 : Debug "Value = D"
      Case 5 : Debug "Value = E"
      Case 6 : Debug "Value = F"
      Default : Debug "不详"
   EndSelect


;【多条件实例】

   Value = 2
   Select Value
      Case 1, 2, 3
         Debug "Value= A 至 F"
      Case 10 To 20, 30, 40 To 50
         Debug "Value 在10至20,40至50之间,也有可能是30"
      Default
         Debug "不详"
  EndSelect














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP