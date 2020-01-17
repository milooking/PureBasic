;***********************************
;迷路仟整理 2019.01.29
;SelectElement_选择元素
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

;【实例1:选择元素】

NewList ListSimple.l()
AddElement(ListSimple()) : ListSimple() = 23
AddElement(ListSimple()) : ListSimple() = 56
AddElement(ListSimple()) : ListSimple() = 12
AddElement(ListSimple()) : ListSimple() = 73

SelectElement(ListSimple(), 0)
Debug "索引号为0的元素: "+Str(ListSimple())

SelectElement(ListSimple(), 2)
Debug "索引号为2的元素: "+Str(ListSimple())

SelectElement(ListSimple(), 1)
Debug "索引号为1的元素: "+Str(ListSimple())

SelectElement(ListSimple(), 3)
Debug "索引号为3的元素: "+Str(ListSimple())



;【实例2:向后历遍】
NewList ListNumber()
AddElement(ListNumber()) : ListNumber() = 1
AddElement(ListNumber()) : ListNumber() = 2
AddElement(ListNumber()) : ListNumber() = 3
AddElement(ListNumber()) : ListNumber() = 4
AddElement(ListNumber()) : ListNumber() = 5

*pElement = SelectElement(ListNumber(), 2)   
While *pElement
   Debug "向后历遍: " + ListNumber()
   *pElement = NextElement(ListNumber()) 
Wend   


;【实例3:向后历遍】
NewList ListValue()
AddElement(ListValue()) : ListValue() = 11
AddElement(ListValue()) : ListValue() = 12
AddElement(ListValue()) : ListValue() = 13
AddElement(ListValue()) : ListValue() = 14
AddElement(ListValue()) : ListValue() = 15

Debug ""
*pElement = SelectElement(ListValue(), 2)   
While *pElement
   Debug "向前历遍: " + ListValue()
   *pElement = PreviousElement(ListValue()) 
Wend   



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP