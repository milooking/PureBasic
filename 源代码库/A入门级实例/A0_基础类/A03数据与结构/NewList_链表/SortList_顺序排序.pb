;***********************************
;迷路仟整理 2019.01.29
;SortList_顺序排序
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

;数值排序
Debug "***************** 数值排序 *****************"
NewList ListSimple()   
           
For k = 1 To 5      
   AddElement(ListSimple()) : ListSimple() = Random(100) 
Next 

ForEach ListSimple() 
   Debug "排序前: " + ListSimple() 
Next 

Debug "============ 升序排序法 ============"
SortList(ListSimple(), #PB_Sort_Ascending)
ForEach ListSimple() 
   Debug "升序法: " + ListSimple() 
Next 


Debug "============ 降序排序法 ============"
SortList(ListSimple(), #PB_Sort_Descending)
ForEach ListSimple() 
   Debug "降序法: " + ListSimple() 
Next 



;字符串排序
Debug "***************** 字符串排序 *****************"
NewList ListSimple$()   
           
For k = 1 To 5      
   AddElement(ListSimple$()) : ListSimple$() = "第"+Str(Random(100)) +"天"
Next 

ForEach ListSimple$() 
   Debug "排序前: " + ListSimple$() 
Next 

Debug "============ 升序排序法 ============"
SortList(ListSimple$(), #PB_Sort_Ascending)
ForEach ListSimple$() 
   Debug "升序法: " + ListSimple$() 
Next 


Debug "============ 降序排序法 ============"
SortList(ListSimple$(), #PB_Sort_Descending)
ForEach ListSimple$() 
   Debug "降序法: " + ListSimple$() 
Next 







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 40
; FirstLine = 24
; EnableXP