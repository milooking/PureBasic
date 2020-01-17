;***********************************
;迷路仟整理 2019.01.29
;MergeLists_合并链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()


NewList ListA$()
AddElement(ListA$()): ListA$() = "a0"
AddElement(ListA$()): ListA$() = "a1"
AddElement(ListA$()): ListA$() = "a2"
AddElement(ListA$()): ListA$() = "a3"

NewList ListB$()
AddElement(ListB$()): ListB$() = "b0"
AddElement(ListB$()): ListB$() = "b1"
AddElement(ListB$()): ListB$() = "b2"
AddElement(ListB$()): ListB$() = "b3"
 
; 将链表ListA$(),插入到链表ListB$()当前元素之后,
SelectElement(ListB$(), 1)
MergeLists(ListA$(), ListB$(), #PB_List_Before)
  
ForEach ListB$()
   Debug ListB$()
Next

;合并后,链表ListA$()被清空内容了
Debug "=========="
ForEach ListA$()
   Debug ListA$()
Next






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; FirstLine = 10
; EnableXP