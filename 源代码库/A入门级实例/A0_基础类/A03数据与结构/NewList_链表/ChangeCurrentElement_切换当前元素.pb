;***********************************
;迷路仟整理 2019.01.29
;ChangeCurrentElement_切换当前元素
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

; ChangeCurrentElement(List(), *NewElement)


NewList ListSimple.w()                           ;创建一个键表
AddElement(ListSimple())    : ListSimple() = 1    ;新增一个元素,并赋值
InsertElement(ListSimple()) : ListSimple() = 2    
AddElement(ListSimple())    : ListSimple() = 3    
InsertElement(ListSimple()) : ListSimple() = 4    
AddElement(ListSimple())    : ListSimple() = 5   

; 获取当前元素的指针
*pElement = @ListSimple()                       ;用*pElement记录下这个元素位置
Debug "当前元素 = "+ListSimple()

ForEach ListSimple()
   Debug "链表顺序: " + ListSimple()
Next 
Debug "当前元素 = "+ListSimple()

ChangeCurrentElement(ListSimple(), *pElement)   ;切换到*pElement这个元素位置
Debug "当前元素 = "+ListSimple()


; 链表顺序: 2
; 链表顺序: 4
; 链表顺序: 5
; 链表顺序: 3
; 链表顺序: 1







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 12
; EnableXP