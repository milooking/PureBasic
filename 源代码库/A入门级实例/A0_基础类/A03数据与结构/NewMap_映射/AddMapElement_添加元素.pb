;***********************************
;迷路仟整理 2019.01.29
;AddMapElement_添加元素
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()


NewMap MapCountry$()
  
;【方法1】:直接赋值
MapCountry$("USA") = "美国"

;【方法2】:间接赋值
MapCountry$("CHI")
MapCountry$() = "中国"

;【方法3】:Add赋值法
AddMapElement(MapCountry$(), "KOR")
MapCountry$() = "韩国"

;【方法4】:Add指针法
*p.string = AddMapElement(MapCountry$(), "JPN")
*p\s = "日本"

ForEach MapCountry$()
   Debug MapCountry$()
Next


















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 7
; EnableXP