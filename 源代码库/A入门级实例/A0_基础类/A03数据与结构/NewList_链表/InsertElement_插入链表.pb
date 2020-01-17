;***********************************
;迷路仟整理 2019.01.29
;InsertElement_插入链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()


; 返回值是链表元素的内容地址指针
; *Result = InsertElement(List()) 

;【实例1:插入新元素】
NewList ListSimple.w()                           ;创建一个键表
AddElement(ListSimple())    : ListSimple() = 1    ;新增一个元素,并赋值
AddElement(ListSimple())    : ListSimple() = 2    ;新增一个元素,并赋值
InsertElement(ListSimple()) : ListSimple() = 3    ;插入一个元素,并赋值  

ForEach ListSimple()
   Debug "链表顺序: " + ListSimple()
Next 

; 链表顺序: 1
; 链表顺序: 3
; 链表顺序: 2


;【实例2:插入判断】
NewList ListAdvanced.l()
If InsertElement(ListAdvanced()) <> 0
   ListAdvanced() = 12345
   Debug "插入元素成功!"
Else
   Debug "出错,插入元素失败!"
EndIf


;【实例3:插入并赋值:链表结构】
NewList ListPoint.POINT()  ;创建一个带结构的键表
InsertElement(ListPoint())  ;插入一个元素
ListPoint()\x = 100         ;对元素结构进行赋
ListPoint()\y = 100


;【实例4:插入并赋值:指针法】
Structure __GadgetInfo
   GadgetID.l
   hGadget.i
   X.w
   Y.w
   W.w
   H.w
   Text$
EndStructure

NewList ListGadget.__GadgetInfo() 
*pGadget.__GadgetInfo = InsertElement(ListGadget())   ;插入一个元素,并返回指元素指针
*pGadget\GadgetID = 1                                 ;用指针进行赋值
*pGadget\x = 100
*pGadget\y = 100
*pGadget\Text$ = "文本框"
Debug "GadgetID   = " + ListGadget()\GadgetID
Debug "GadgetX    = " + ListGadget()\x
Debug "GadgetY    = " + ListGadget()\y
Debug "GadgetText = " + ListGadget()\Text$

*pGadget.__GadgetInfo = InsertElement(ListGadget())   ;插入一个元素,并返回指元素指针
*pGadget\GadgetID = 2                                 ;用指针进行赋值
*pGadget\x = 200
*pGadget\y = 200
*pGadget\Text$ = "按键"
Debug "GadgetID   = " + ListGadget()\GadgetID
Debug "GadgetX    = " + ListGadget()\x
Debug "GadgetY    = " + ListGadget()\y
Debug "GadgetText = " + ListGadget()\Text$



;【实例5:新增顺序】
NewList ListSort.l() 

AddElement(ListSort()) : ListSort() = 1
AddElement(ListSort()) : ListSort() = 2
AddElement(ListSort()) : ListSort() = 3

InsertElement(ListSort()) : ListSort() = 4   ;在3前面插入4
InsertElement(ListSort()) : ListSort() = 5   ;在4前面插入5

FirstElement(ListSort())   
InsertElement(ListSort()) : ListSort() = 6   ;在1前面插入6
InsertElement(ListSort()) : ListSort() = 7   ;在7前面插入6

LastElement(ListSort())                      ;跳到最后一个元素,这时是3
InsertElement(ListSort()) : ListSort() = 8   ;在3前面插入8
InsertElement(ListSort()) : ListSort() = 9   ;在8前面插入9

ForEach ListSort()
   Debug "链表顺序: " + ListSort()
Next 
; 
; 链表顺序: 7
; 链表顺序: 6
; 链表顺序: 1
; 链表顺序: 2
; 链表顺序: 5
; 链表顺序: 4
; 链表顺序: 9
; 链表顺序: 8
; 链表顺序: 3


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 63
; FirstLine = 55
; Folding = -
; EnableXP