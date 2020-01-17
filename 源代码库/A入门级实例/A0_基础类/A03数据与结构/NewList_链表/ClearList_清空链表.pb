;***********************************
;迷路仟整理 2019.01.29
;ClearList_清空链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()



NewList ListNumbers.w()
For i = 1 To 100
   AddElement(ListNumbers())
   ListNumbers() = i
Next

Debug "链表ListNumbers()的元素数量: " + Str(ListSize(ListNumbers()))

ClearList(ListNumbers())   ;清空元素
Debug "链表ListNumbers()的元素数量: " + Str(ListSize(ListNumbers()))












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP