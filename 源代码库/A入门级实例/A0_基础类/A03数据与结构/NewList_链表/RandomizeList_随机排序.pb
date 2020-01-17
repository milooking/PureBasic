;***********************************
;迷路仟整理 2019.01.29
;RandomizeList_随机排序
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

Debug "***************** 数值排序 *****************"
NewList ListSimple()   
                
For k = 1 To 10      
   AddElement(ListSimple()) : ListSimple() = k
Next 

ForEach ListSimple() 
   Debug "随机前: " + ListSimple() 
Next 

Debug "============ 随机排序法 ============"
RandomizeList(ListSimple())
ForEach ListSimple() 
   Debug "随机后: " + ListSimple() 
Next 


Debug "============ 随机排序法 ============"
RandomizeList(ListSimple())
ForEach ListSimple() 
   Debug "随机后: " + ListSimple() 
Next 

Debug "***************** 字符串排序 *****************"
NewList ListSimple$()   
                
For k = 1 To 10      
   AddElement(ListSimple$()) : ListSimple$() = "第"+Str(k) +"天"
Next 

ForEach ListSimple$() 
   Debug "随机前: " + ListSimple$() 
Next 

Debug "============ 随机排序法 ============"
RandomizeList(ListSimple$())
ForEach ListSimple$() 
   Debug "随机后: " + ListSimple$() 
Next 


Debug "============ 随机排序法 ============"
RandomizeList(ListSimple$())
ForEach ListSimple$() 
   Debug "随机后: " + ListSimple$() 
Next 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 36
; FirstLine = 22
; EnableXP