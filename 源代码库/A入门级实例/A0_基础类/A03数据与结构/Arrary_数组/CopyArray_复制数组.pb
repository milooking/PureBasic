;***********************************
;迷路仟整理 2019.01.28
;ArraySize_数组大小
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()


Dim DimNumber(5)
Dim DimNumberCopy(10)

DimNumber(0) = 128
DimNumber(5) = 256

Debug "复制前的大小: "+Str(ArraySize(DimNumberCopy())) ;10

CopyArray(DimNumber(), DimNumberCopy())

Debug "复制后的大小: "+Str(ArraySize(DimNumberCopy())) ; 5
Debug DimNumberCopy(0)
Debug DimNumberCopy(5)







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP