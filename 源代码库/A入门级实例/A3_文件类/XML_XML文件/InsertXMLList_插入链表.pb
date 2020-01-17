;***********************************
;迷路仟整理 2019.01.30
;InsertXMLList_插入链表
;***********************************

; <list>
;   <element>红</element>
;   <element>绿</element>
;   <element>蓝</element>
; </list>
;
NewList ListColor$()
AddElement(ListColor$()) : ListColor$() = "红"
AddElement(ListColor$()) : ListColor$() = "绿"
AddElement(ListColor$()) : ListColor$() = "蓝"

If CreateXML(0)
   InsertXMLList(RootXMLNode(0), ListColor$())
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf

;【多维数组】
; <list>
;   <element>
;     <x>100</x>
;     <y>200</y>
;   </element>
;   <element>
;     <x>200</x>
;     <y>400</y>
;   </element>
; </list>
;
NewList ListPoint.POINTS()

For i = 1 To 2
   AddElement(ListPoint())
   ListPoint()\x = 100 * i
   ListPoint()\y = 200 * i
Next i

If CreateXML(0)
   InsertXMLList(RootXMLNode(0), ListPoint())
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; FirstLine = 3
; EnableXP