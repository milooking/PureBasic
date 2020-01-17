;***********************************
;迷路仟整理 2019.01.29
;FirstElement_获取首元素
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()



;【实例1:获取首元素】
NewList ListSimple.w()                         ;创建一个键表
AddElement(ListSimple()) : ListSimple() = 11    ;新增一个元素,并赋值
AddElement(ListSimple()) : ListSimple() = 22    ;新增一个元素,并赋值  
AddElement(ListSimple()) : ListSimple() = 33    ;新增一个元素,并赋值  

Debug "当前元素: " + ListSimple()
FirstElement(ListSimple())
Debug "首 元 素: " + ListSimple()


;【实例2:获取判断】
NewList ListAdvanced.l()
If FirstElement(ListAdvanced()) <> 0
   Debug "首元素: " + ListAdvanced()
Else
   Debug "链表没有元素!"
EndIf

AddElement(ListAdvanced())
ListAdvanced() = 99
If FirstElement(ListAdvanced()) <> 0
   Debug "首元素: " + ListAdvanced()
Else
   Debug "链表没有元素!"
EndIf


;【实例3:指针法】
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
AddElement(ListGadget())      ;新增一个元素,并返回指元素指针
ListGadget()\GadgetID = 1     ;用指针进行赋值
ListGadget()\x = 100
ListGadget()\y = 100
ListGadget()\Text$ = "文本框"

AddElement(ListGadget())      ;新增一个元素,并返回指元素指针
ListGadget()\GadgetID = 2     ;用指针进行赋值
ListGadget()\x = 200
ListGadget()\y = 200
ListGadget()\Text$ = "按键"


*pGadget.__GadgetInfo = FirstElement(ListGadget())
Debug "GadgetID   = " + ListGadget()\GadgetID
Debug "GadgetX    = " + ListGadget()\x
Debug "GadgetY    = " + ListGadget()\y
Debug "GadgetText = " + ListGadget()\Text$


;【实例4:循环历遍】
NewList ListNumber()
AddElement(ListNumber()) : ListNumber() = 1
AddElement(ListNumber()) : ListNumber() = 2
AddElement(ListNumber()) : ListNumber() = 3
AddElement(ListNumber()) : ListNumber() = 4
AddElement(ListNumber()) : ListNumber() = 5

*pElement = FirstElement(ListNumber())   
While *pElement
   Debug "循环历遍: " + ListNumber()
   *pElement = NextElement(ListNumber()) 
Wend   


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = +
; EnableXP