;***********************************
;迷路仟整理 2019.01.29
;ResetMap_置位映射
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()


NewMap MapAge()

MapAge("花千骨") = 15
MapAge("白子画") = 30
MapAge("杀阡陌") = 40
MapAge("东方彧卿") = 20

ResetMap(MapAge())               ;置位映射,主要用于循环
While NextMapElement(MapAge())
   Debug MapKey(MapAge()) + ":" + MapAge()
Wend














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP