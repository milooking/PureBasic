;***********************************
;迷路仟整理 2019.01.29
;SortStructuredList_顺序排序(带结构)
;***********************************
;【注】为了规范代码,建议定义链表时,
;      以List开头,如NewList ListValue(),
;      全局变量时以_List开头,如Global NewList _ListValue()

; SortStructuredList(ListName(), Options, OffsetOf(Structure\Field), TypeOf(Structure\Field) [, Start, End])

; Options: #PB_Sort_Ascending/#PB_Sort_Descending/#PB_Sort_NoCase 
; TypeOf: #PB_Byte/#PB_Word/#PB_Long/#PB_String/#PB_Float/  #PB_Double/#PB_Quad/#PB_Character/#PB_Integer/#PB_Ascii/#PB_Unicode


Structure __AnimalInfo
   Name$
   Speed.l
EndStructure

Dim DimAnimal.__AnimalInfo(2)

DimAnimal(0)\Name$ = "老虎"
DimAnimal(0)\Speed = 10

DimAnimal(1)\Name$ = "豹子"
DimAnimal(1)\Speed = 40

DimAnimal(2)\Name$ = "斑马"
DimAnimal(2)\Speed = 30

Debug "***************** 排序前 *****************"
For k = 0 To 2
   Debug DimAnimal(k)\Name$+" - Speed: "+Str(DimAnimal(k)\Speed)
Next


Debug "***************** 按速度排序 *****************"
SortStructuredArray(DimAnimal(), 0, OffsetOf(__AnimalInfo\Speed), TypeOf(__AnimalInfo\Speed))
For k = 0 To 2
   Debug DimAnimal(k)\Name$+" - Speed: "+Str(DimAnimal(k)\Speed)
Next

Debug "***************** 按名称排序 *****************"
SortStructuredArray(DimAnimal(), 0, OffsetOf(__AnimalInfo\Name$), TypeOf(__AnimalInfo\Name$))
For k = 0 To 2
   Debug DimAnimal(k)\Name$+" - Speed: "+Str(DimAnimal(k)\Speed)
Next





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 4
; Folding = -
; EnableXP