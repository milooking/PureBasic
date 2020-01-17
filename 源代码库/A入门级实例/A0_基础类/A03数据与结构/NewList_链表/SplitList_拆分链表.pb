;***********************************
;迷路仟整理 2019.01.29
;SplitList_拆分链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()


NewList ListValueA()
NewList ListValueB()

For i = 0 To 10
   AddElement(ListValueA())
   ListValueA() = i
Next


SelectElement(ListValueA(), 5)         ; 选择索引号为5的元素,
SplitList(ListValueA(), ListValueB())  ; 以当前元素位置(包括当前元素)及后面的元素,拆分至ListValueB()链表


Debug " -- ListValue() -- "
ForEach ListValueA()
   Debug "ListValueA() = " + ListValueA()
Next

Debug " -- ListValue() -- "
ForEach ListValueB()
   Debug "ListValueB() = " + ListValueB()
Next






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP