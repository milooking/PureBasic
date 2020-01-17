;***********************************
;迷路仟整理 2019.01.28
;While_Wend While循环
;***********************************

; While <expression>
;   ...
; Wend
;满足While条件时,执行命令


;【基本用法】
   b = 0
   a = 10
   While a = 10 
      b = b+1 
      If b=10 
         a=11 
      EndIf 
   Wend 
   Debug a
   Debug b


;【死循环用法】
   ;死循环
;    While #True
;       b = b+1 
;       Debug b
;    Wend 


;【List 链表用法】 
   NewList ListNumber()
   AddElement(ListNumber()) : ListNumber() = 1
   AddElement(ListNumber()) : ListNumber() = 2
   AddElement(ListNumber()) : ListNumber() = 3
   AddElement(ListNumber()) : ListNumber() = 4
   AddElement(ListNumber()) : ListNumber() = 5
   
   ;方法1: 常规顺序法
   Debug "方法1: 常规顺序法"
   ResetList(ListNumber())             ;置位链表,
   While NextElement(ListNumber())    
      Debug ListNumber()
   Wend     

   ;方法2: 指针顺序法
   Debug "方法2: 指针顺序法"
   *pElement = FirstElement(ListNumber())   
   While *pElement
      Debug ListNumber()
      *pElement = NextElement(ListNumber()) 
   Wend     

   ;方法3: 指针逆序法
   Debug "方法3: 指针逆序法"
   *pElement = LastElement(ListNumber())   
   While *pElement
      Debug ListNumber()
      *pElement = PreviousElement(ListNumber()) 
   Wend     

;【Map 映射用法】 
   NewMap MapNumber$()
   AddMapElement(MapNumber$(), "1") : MapNumber$() = "A"
   AddMapElement(MapNumber$(), "2") : MapNumber$() = "B"
   AddMapElement(MapNumber$(), "3") : MapNumber$() = "C"
   AddMapElement(MapNumber$(), "4") : MapNumber$() = "D"
   AddMapElement(MapNumber$(), "5") : MapNumber$() = "E"

   Debug "映射用法"
   ResetMap(MapNumber$())
   While NextMapElement(MapNumber$())
      Debug MapNumber$()
   Wend


















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP