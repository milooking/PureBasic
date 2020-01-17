;***********************************
;迷路仟整理 2019.01.30
;InsertJSONList_插入链表
;***********************************


NewList ListName$()
AddElement(ListName$()): ListName$() = "花千骨"
AddElement(ListName$()): ListName$() = "白子画"
AddElement(ListName$()): ListName$() = "杀阡陌"

If CreateJSON(0)
   InsertJSONList(JSONValue(0), ListName$())
   Debug ComposeJSON(0, #PB_JSON_PrettyPrint)
EndIf








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP