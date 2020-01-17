;***********************************
;迷路仟整理 2019.01.29
;FindMapElement_查找元素
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()



NewList ListFriends$()
NewList ListFriendsCopy$()

AddElement(ListFriends$()) : ListFriends$() = "花千骨"
AddElement(ListFriends$()) : ListFriends$() = "白子画"
AddElement(ListFriends$()) : ListFriends$() = "杀阡陌"
AddElement(ListFriends$()) : ListFriends$() = "东方彧卿"

CopyList(ListFriends$(), ListFriendsCopy$())

ForEach ListFriendsCopy$()
   Debug ListFriendsCopy$()
Next











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; EnableXP