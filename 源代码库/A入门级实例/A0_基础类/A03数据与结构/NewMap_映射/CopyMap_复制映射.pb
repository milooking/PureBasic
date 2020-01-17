;***********************************
;迷路仟整理 2019.01.29
;CopyMap_复制映射
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()


NewMap MapAge()
NewMap MapAgeCopy()

MapAge("花千骨") = 15
MapAge("白子画") = 30
MapAge("杀阡陌") = 40
MapAge("东方彧卿") = 20

CopyMap(MapAge(), MapAgeCopy())

Debug MapAgeCopy("花千骨")
Debug MapAgeCopy("白子画")
Debug MapAgeCopy("杀阡陌")
Debug MapAgeCopy("东方彧卿")


















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; EnableXP