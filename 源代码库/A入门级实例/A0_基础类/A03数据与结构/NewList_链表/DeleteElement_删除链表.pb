;***********************************
;迷路仟整理 2019.01.29
;CopyList_复制链表
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()



NewList ListPeople$()

AddElement(ListPeople$()) : ListPeople$() = "花千骨"
AddElement(ListPeople$()) : ListPeople$() = "白子画"
AddElement(ListPeople$()) : ListPeople$() = "杀阡陌"
AddElement(ListPeople$()) : ListPeople$() = "东方彧卿"

Debug "删除前: ============="
ForEach ListPeople$()
   Debug ListPeople$()
Next

FirstElement(ListPeople$())
DeleteElement(ListPeople$(), 1)

Debug "删除后: ============="
ForEach ListPeople$()
   Debug ListPeople$()
Next











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableXP