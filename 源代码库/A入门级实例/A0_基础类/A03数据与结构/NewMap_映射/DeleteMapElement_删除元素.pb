;***********************************
;迷路仟整理 2019.01.29
;DeleteMapElement_删除元素
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()


NewMap MapAge()

MapAge("花千骨") = 15
MapAge("白子画") = 30
MapAge("杀阡陌") = 40
MapAge("东方彧卿") = 20

If FindMapElement(MapAge(), "杀阡陌") 
   DeleteMapElement(MapAge(), "杀阡陌")      ;删除它
   Debug "找到这个元素,盘它!"  
Else
   Debug "元素不存在!"    
EndIf

ForEach MapAge()
   Debug MapKey(MapAge()) + ":" + MapAge()
Next












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP