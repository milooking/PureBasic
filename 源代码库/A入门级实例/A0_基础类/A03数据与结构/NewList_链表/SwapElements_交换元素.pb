;***********************************
;迷路仟整理 2019.01.29
;SwapElements_交换元素
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()


NewList ListNumber()

For k=0 To 10
   AddElement(ListNumber())
   ListNumber() = k
Next

ForEach ListNumber()
   Debug "交换前:" + ListNumber()
Next
 
 
*pFirstElement  = SelectElement(ListNumber(), 3) ;获取索引号为3的元素指针
*pSecondElement = SelectElement(ListNumber(), 9) ;获取索引号为9的元素指针

SwapElements(ListNumber(), *pFirstElement, *pSecondElement);将两个元素的位置互换

Debug ""
ForEach ListNumber()
   Debug "交换后:" + ListNumber()
Next


;采用Swap进行互换,这里要用指针指向元素的内容位置,否则,互换的是指针本身
Debug "==========交换指针本身=========="
Debug "交换前:*pFirstElement  = 0x" + Hex(*pFirstElement,  #PB_Long)
Debug "交换前:*pSecondElement = 0x" + Hex(*pSecondElement, #PB_Long)

Swap *pFirstElement, *pSecondElement

Debug "交换后:*pFirstElement  = 0x" + Hex(*pFirstElement,  #PB_Long)
Debug "交换后:*pSecondElement = 0x" + Hex(*pSecondElement, #PB_Long)


Debug "==========交换元素内容=========="
*pFirst.long  = SelectElement(ListNumber(), 2) ;获取索引号为2的元素指针及内容指向
*pSecond.long = SelectElement(ListNumber(), 7) ;获取索引号为7的元素指针及内容指向

Swap *pFirst\l, *pSecond\l
ForEach ListNumber()
   Debug "交换后:" + ListNumber()
Next

*pFirstElement  = SelectElement(ListNumber(), 1) ;获取索引号为1的元素指针
*pSecondElement = SelectElement(ListNumber(), 5) ;获取索引号为5的元素指针












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP