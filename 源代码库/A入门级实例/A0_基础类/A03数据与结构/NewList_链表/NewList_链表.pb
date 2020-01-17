;***********************************
;迷路仟整理 2019.01.28
;NewList 链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

;链表是一个同一类型的数据集合,链表变量表达的这个集合当前指针下的成员.
;如实例1 :链表ListNumber()，有三个成员，ListNumber()本身，指的是最后一个成员

;【实例1:简单实例】
Debug "实例1:简单实例"
NewList ListNumber()
AddElement(ListNumber()) : ListNumber() = 10
AddElement(ListNumber()) : ListNumber() = 20
AddElement(ListNumber()) : ListNumber() = 30
ForEach ListNumber()
   Debug ListNumber()
Next
Debug "ListNumber() = " + ListNumber()


;【实例2:函数支持】 不支持ProcedureDLL(编译后无效)
Debug ""
Debug "实例2:函数支持"
NewList ListTest()
AddElement(ListTest()) : ListTest() = 1
AddElement(ListTest()) : ListTest() = 2

Procedure Fun_DebugList(List ListParam(), Count)
   For k = 1 To Count
      AddElement(ListParam())
      ListParam() = 2+k
   Next 
EndProcedure

Fun_DebugList(ListTest(), 3)
ForEach ListTest()
   Debug ListTest()
Next


;【实例3:链表历遍】
Debug ""
Debug "实例3:链表历遍"
Debug "常规历遍"
ForEach ListTest()
   Debug ListTest()
Next

Debug "顺序历遍"
ResetList(ListTest())             ;置位链表,
While NextElement(ListTest())    
   Debug ListTest()
Wend     


Debug "顺序历遍指针法"
*pElement = FirstElement(ListTest())   
While *pElement
   Debug ListTest()
   *pElement = NextElement(ListTest())     ;获取下一个链表
Wend    

Debug "逆序历遍指针法"
*pElement = LastElement(ListTest())   
While *pElement
   Debug ListTest()
   *pElement = PreviousElement(ListTest()) ;获取上一个链表
Wend     


;【实例4:结构链表】
Debug ""
Debug "实例4:结构链表"
Structure __ListStructInfo
   Text$
   Value.l
EndStructure

NewList ListTestStruct.__ListStructInfo()
AddElement(ListTestStruct()) 
ListTestStruct()\Text$ = "A"
ListTestStruct()\Value = 1

AddElement(ListTestStruct()) 
ListTestStruct()\Text$ = "B"
ListTestStruct()\Value = 2

AddElement(ListTestStruct()) 
ListTestStruct()\Text$ = "C"
ListTestStruct()\Value = 3

ForEach ListTestStruct()
   Debug ListTestStruct()\Text$ + ":" + Str(ListTestStruct()\Value)
Next

;【实例5:获取链表元素数量】
Debug ""
Debug "实例5:获取链表元素数量"
Debug ListSize(ListTestStruct())


;【实例6:清空链表元素】
Debug ""
Debug "实例6:清空链表元素"
ClearList(ListTestStruct()) 
Debug ListSize(ListTestStruct())


;【实例7:注销链表元素】
FreeList(ListTestStruct()) 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 110
; FirstLine = 82
; Folding = 9
; EnableXP