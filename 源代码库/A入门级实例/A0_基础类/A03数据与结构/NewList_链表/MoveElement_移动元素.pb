;***********************************
;迷路仟整理 2019.01.29
;MergeLists_合并链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()


NewList ListNumber()

For k = 0 To 10
   AddElement(ListNumber())
   ListNumber() = k
Next


ForEach ListNumber()
   Debug "初始顺序: " + ListNumber()
Next

*pElement = SelectElement(ListNumber(), 5)               ;选择索引为5的元素

SelectElement(ListNumber(), 0)
MoveElement(ListNumber(), #PB_List_After, *pElement)     ;将首元素移动到索引为5的元素后面
 
SelectElement(ListNumber(), 10)
MoveElement(ListNumber(), #PB_List_First)                ;将索引为10的元素移动到最前面
 
ForEach ListNumber()
   Debug "移动元素后: " + ListNumber()
Next






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 31
; FirstLine = 12
; EnableXP