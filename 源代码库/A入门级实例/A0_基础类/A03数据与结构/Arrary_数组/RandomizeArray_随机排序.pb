;***********************************
;迷路仟整理 2019.01.28
;RandomizeArray_随机排序
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()


Debug "***************** 数值排序 *****************"
Dim DimArray(10)
For k = 0 To 10
   DimArray(k) = k
Next 
For k = 0 To 10
   Debug "排序前: " + DimArray(k) 
Next 

Debug "============ 随机排序法 ============"
RandomizeArray(DimArray())
For k = 0 To 10
   Debug "随机排序: " + DimArray(k) 
Next 


Debug "***************** 字符串排序 *****************"
Dim DimArray$(10)
For k = 0 To 10
   DimArray$(k) = "第"+Str(k)+"次"
Next 
For k = 0 To 10
   Debug "排序前: " + DimArray$(k) 
Next 

Debug "============ 随机排序法 ============"
RandomizeArray(DimArray$())
For k = 0 To 10
   Debug "随机排序: " + DimArray$(k) 
Next 







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 4
; EnableXP