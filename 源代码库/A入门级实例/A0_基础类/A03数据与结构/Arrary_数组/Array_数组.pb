;***********************************
;迷路仟整理 2019.01.28
;Array_数组 Dim 数组
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()

;数组有两种形式,
;一种是独立变量的,下标从0开始至定义值,如DimValue(10), 共有11个成员
;一种是结构构数组,下标从0开始至定义值-1, 如DimValue[10], 只有10个成员

;实例1:字符串数组
Dim DimArray$(10) 
DimArray$(10) = "X"   ;这里有11个成员,最大成员下标为10

;实例2:数值数组
Dim DimArray.l(10) 
DimArray(5) = 5


;实例3:单维数组
Dim DimArray(41)
DimArray(0) = 1
DimArray(1) = 2 


;实例3:多维数组
Dim DimPixel(1024-1,768-1)
DimPixel(0,0) = $FF0000
DimPixel(1,0) = $00FF00
DimPixel(1,1) = $0000FF


;实例4:单维结构数组
Structure __ArrayParam
   DimNumber.l[100]
EndStructure

Number4.__ArrayParam
Number4\DimNumber[0] = 123


;实例5:多维结构数组
Structure __ArrayNumber
   Array DimNumber.l(10,10,10)
EndStructure

Number5.__ArrayNumber
Number5\DimNumber(10,10,10) = 123


;实例5:释放数组
FreeArray(DimArray())



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 52
; FirstLine = 23
; Folding = -
; EnableXP