;***********************************
;迷路仟整理 2019.01.29
;AddElement_添加链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

; 返回值是链表元素的内容地址指针
; *Result = AddElement(List())
; 除了AddElement()添加链表,还有一个命令InsertElement()



;【实例1:新增元素】
NewList ListSimple.w()                         ;创建一个键表
AddElement(ListSimple()) : ListSimple() = 23    ;新增一个元素,并赋值
AddElement(ListSimple()) : ListSimple() = 45    ;新增一个元素,并赋值  


;【实例2:新增判断】
NewList ListAdvanced.l()
If AddElement(ListAdvanced()) <> 0
   ListAdvanced() = 12345
   Debug "新增元素成功!"
Else
   Debug "出错,新增元素失败!"
EndIf

;【实例3:新增赋值:链表结构】
NewList ListPoint.POINT()  ;创建一个带结构的键表
AddElement(ListPoint())     ;新增一个元素
ListPoint()\x = 100         ;对元素结构进行赋
ListPoint()\y = 100

;【实例4:新增赋值:指针法】
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
*pGadget.__GadgetInfo = AddElement(ListGadget())   ;新增一个元素,并返回指元素指针
*pGadget\GadgetID = 1                              ;用指针进行赋值
*pGadget\x = 100
*pGadget\y = 100
*pGadget\Text$ = "文本框"
Debug "GadgetID   = " + ListGadget()\GadgetID
Debug "GadgetX    = " + ListGadget()\x
Debug "GadgetY    = " + ListGadget()\y
Debug "GadgetText = " + ListGadget()\Text$

*pGadget.__GadgetInfo = AddElement(ListGadget())   ;新增一个元素,并返回指元素指针
*pGadget\GadgetID = 2                              ;用指针进行赋值
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

FirstElement(ListSort())
AddElement(ListSort()) : ListSort() = 4
AddElement(ListSort()) : ListSort() = 5

LastElement(ListSort())
AddElement(ListSort()) : ListSort() = 7
AddElement(ListSort()) : ListSort() = 8

ForEach ListSort()
   Debug "链表顺序: " + ListSort()
Next 
; 
; 链表顺序: 1
; 链表顺序: 4
; 链表顺序: 5
; 链表顺序: 2
; 链表顺序: 3
; 链表顺序: 7
; 链表顺序: 8

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 64
; FirstLine = 56
; Folding = +
; EnableXP