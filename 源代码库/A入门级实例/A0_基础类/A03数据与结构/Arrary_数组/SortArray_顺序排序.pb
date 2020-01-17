;***********************************
;迷路仟整理 2019.01.28
;SortArray_顺序排序
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()


Debug "***************** 数值排序 *****************"
Dim DimArray(10)
For k = 0 To 10
   DimArray(k) = Random(100)
Next 
For k = 0 To 10
   Debug "排序前: " + DimArray(k) 
Next 

Debug "============ 升序排序法 ============"
SortArray(DimArray(), #PB_Sort_Ascending)
For k = 0 To 10
   Debug "升序法: " + DimArray(k) 
Next 

Debug "============ 降序排序法 ============"
SortArray(DimArray(), #PB_Sort_Descending)
For k = 0 To 10
   Debug "降序法: " + DimArray(k) 
Next 

Debug "***************** 字符串排序 *****************"
Dim DimArray$(10)
For k = 0 To 10
   DimArray$(k) = "第"+Str(Random(100))+"次"
Next 
For k = 0 To 10
   Debug "排序前: " + DimArray$(k) 
Next 

Debug "============ 升序排序法 ============"
SortArray(DimArray$(), #PB_Sort_Ascending)
For k = 0 To 10
   Debug "升序法: " + DimArray$(k) 
Next 

Debug "============ 降序排序法 ============"
SortArray(DimArray$(), #PB_Sort_Descending)
For k = 0 To 10
   Debug "降序法: " + DimArray$(k) 
Next 








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP