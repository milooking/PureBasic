;***********************************
;迷路仟整理 2019.01.28
;SortStructuredArray_顺序排序
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()


Structure __AnimalInfo
   Name$
   Speed.l
EndStructure

NewList ListAnimal.__AnimalInfo()

AddElement(ListAnimal())
ListAnimal()\Name$ = "老虎"
ListAnimal()\Speed = 10

AddElement(ListAnimal())
ListAnimal()\Name$ = "豹子"
ListAnimal()\Speed = 40

AddElement(ListAnimal())
ListAnimal()\Name$ = "斑马"
ListAnimal()\Speed = 30






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; Folding = -
; EnableXP