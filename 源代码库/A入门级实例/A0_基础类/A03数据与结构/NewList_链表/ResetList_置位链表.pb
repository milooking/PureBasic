;***********************************
;迷路仟整理 2019.01.29
;ResetList_置位链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

;ResetList();主要作用是用于循环历遍,比较复杂的用法则是用于链表的镜像克隆

NewList ListNumber.l()
AddElement(ListNumber()) : ListNumber() = 1
AddElement(ListNumber()) : ListNumber() = 2
AddElement(ListNumber()) : ListNumber() = 3
AddElement(ListNumber()) : ListNumber() = 4
AddElement(ListNumber()) : ListNumber() = 5

ResetList(ListNumber())
While NextElement(ListNumber())
   Debug ListNumber() 
Wend


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP