;***********************************
;迷路仟整理 2019.01.28
;ForEach_Next 循环
;***********************************

; ForEach List() Or Map()
;   ...
; Next [List() Or Map()]

;【List 链表用法】
NewList ListNumber()
AddElement(ListNumber()) : ListNumber() = 10
AddElement(ListNumber()) : ListNumber() = 20
AddElement(ListNumber()) : ListNumber() = 30
 
ForEach ListNumber()
   Debug ListNumber()   ;循环历遍
Next

;【Map 映射用法】
NewMap MapCountry$()
MapCountry$("US") = "米国"
MapCountry$("FR") = "法国"
MapCountry$("GE") = "德国"

ForEach MapCountry$()
   Debug MapCountry$()
Next









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; FirstLine = 11
; EnableXP