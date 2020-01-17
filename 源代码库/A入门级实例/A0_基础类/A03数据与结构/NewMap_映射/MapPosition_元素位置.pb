;***********************************
;迷路仟整理 2019.01.29
;MapPosition_元素位置, 
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()
; PushMapPosition()/PopMapPosition()是配对使用的,主要用于内循环,防止死循环

NewMap MapNumber()

MapNumber("A") = 1
MapNumber("B") = 2
MapNumber("C") = 5
MapNumber("D") = 3
MapNumber("E") = 2
MapNumber("F") = 5

;删除重复内容的元素
ForEach MapNumber()
   Value = MapNumber()
   PushMapPosition(MapNumber())        ;设置位置
   While NextMapElement(MapNumber())
      If MapNumber() = Value 
         DeleteMapElement(MapNumber())
      EndIf
   Wend
   PopMapPosition(MapNumber())         ;恢复位置
Next

ForEach MapNumber()
   Debug MapKey(MapNumber()) + ":" + MapNumber()
Next












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; FirstLine = 1
; EnableXP