;***********************************
;迷路仟整理 2019.01.29
;ClearMap_清空元素, 
;***********************************
;【注】为了规范代码,建议定义 映射时,
;      以Map开头,如NewMap MapValue(),
;      全局变量时以_Map开头,如Global NewMap _MapValue()

NewMap MapFriends$()

MapFriends$("1") = "花千骨"
MapFriends$("2") = "白子画"
MapFriends$("3") = "杀阡陌"
MapFriends$("4") = "东方彧卿"

ForEach MapFriends$()
   Debug MapFriends$()
Next

ClearMap(MapNumber())      ;清空它

;清空后.
ForEach MapFriends$()
   Debug MapFriends$()
Next


FreeMap(MapNumber())       ;释放/注销映射






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; EnableXP