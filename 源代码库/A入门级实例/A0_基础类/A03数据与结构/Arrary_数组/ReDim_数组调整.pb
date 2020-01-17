;***********************************
;迷路仟整理 2019.01.28
;Dim/ReDim 数组
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()

;ReDim name.<type>(<expression>, [<expression>], ...) 

Dim DimReArray.l(1)   ;一开始只有2个成员
DimReArray(0) = 1
DimReArray(1) = 2

ReDim DimReArray(4)   ;ReDim后,变成5个成员,原先的成员数据保留着
DimReArray(2) = 3

For k = 0 To 2
   Debug DimReArray(k)
Next





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP