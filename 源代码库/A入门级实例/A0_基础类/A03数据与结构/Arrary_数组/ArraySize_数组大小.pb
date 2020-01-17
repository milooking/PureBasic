;***********************************
;迷路仟整理 2019.01.28
;ArraySize_数组大小
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()



Dim DimArray.l(10)
Debug ArraySize(DimArray())       ; 10


Dim DimMulti.l(10, 20, 30)
Debug ArraySize(DimMulti(), 2)    ; 20,多维数组要指明维度




Dim DimTest.q(99999999999999999)    ;下标太大了
If ArraySize(DimTest()) <> -1
   DimTest(12345) = 123  
Else
   Debug "数组DimTest()初始化失败."
EndIf







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; EnableXP