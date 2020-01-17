;***********************************
;迷路仟整理 2019.01.29
;ListPosition_元素位置: 
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

;PushListPosition()/PopListPosition()是配对使用的,主要用于内循环,防止死循环

NewList ListNumber()
AddElement(ListNumber()): ListNumber() = 1
AddElement(ListNumber()): ListNumber() = 2
AddElement(ListNumber()): ListNumber() = 5
AddElement(ListNumber()): ListNumber() = 3
AddElement(ListNumber()): ListNumber() = 5
AddElement(ListNumber()): ListNumber() = 2

;删除重复的元素
ForEach ListNumber()                      ;主循环
   Value = ListNumber()
   PushListPosition(ListNumber())         ;记录当前的位置
   While NextElement(ListNumber())        ;内循环
      If ListNumber() = Value 
         DeleteElement(ListNumber())
      EndIf
   Wend
   PopListPosition(ListNumber())          ;恢复之前的位置,否则会进入死循环,
Next

ForEach ListNumber()
   Debug ListNumber()
Next







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 24
; EnableXP