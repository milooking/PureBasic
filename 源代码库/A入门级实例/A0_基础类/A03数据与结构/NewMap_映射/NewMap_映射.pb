;***********************************
;迷路仟整理 2019.01.28
;NewMap 映射
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()

;映射是一个同一类型的数据希哈表集合,映射变量表达的这个集合当前指针下的成员.
;映射相当于一个索引号为字符串的一维数组
;映射的排序顺序，不以先来后到为顺序，而是以希哈表的排序为准，
;所以，当功能需要严格要求排列顺序时，建议和List或List+Map

;【实例1:简单实例】
Debug "实例1:简单实例"
NewMap MapCountry$()
MapCountry$("GE") = "德国"
MapCountry$("FR") = "法国"
MapCountry$("UK") = "英国"

ForEach MapCountry$()
   Debug MapCountry$()
Next
Debug "MapCountry$('FR') = " + MapCountry$("FR")


;【实例2:函数支持】
Debug ""
Debug "实例2:函数支持"
NewMap MapNumber()
MapNumber("A") : MapNumber() = 1
MapNumber("B") : MapNumber() = 2

Procedure Fun_DebugMap(Map MapParam(), Count)
   For k = 1 To Count
      AddMapElement(MapParam(), Chr('B'+k))  ;'B' = Asc("B")
      MapParam() = 2+k
   Next 
EndProcedure

Fun_DebugMap(MapNumber(), 3)
ForEach MapNumber()
   Debug MapKey(MapNumber())+":"+MapNumber()
Next


;【实例3:链表历遍】 #DQUOTE$是双引号的字符串常量，相当于Chr($22)
Debug ""
Debug "实例3:链表历遍1"
ForEach MapNumber()
   Text$ = "MapNumber("+#DQUOTE$+MapKey(MapNumber())+#DQUOTE$+") = "+MapNumber()
   Debug Text$
Next

Debug ""
Debug "实例3:链表历遍2"
ResetMap(MapNumber())
While NextMapElement(MapNumber())
   Text$ = "MapNumber("+#DQUOTE$+MapKey(MapNumber())+#DQUOTE$+") = "+MapNumber()
   Debug Text$
Wend


;【实例4:映射元素数量】
Debug MapSize(MapNumber())


;【实例5:注销映射元素】
Debug FreeMap(MapNumber())




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 65
; FirstLine = 32
; Folding = +
; EnableXP