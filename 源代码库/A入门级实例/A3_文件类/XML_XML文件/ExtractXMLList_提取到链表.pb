;***********************************
;迷路仟整理 2019.01.30
;ExtractXMLList_提取到链表
;***********************************

XmlText$ = "<array><element>1</element><element>10</element><element>100</element></array>"

If ParseXML(0, XmlText$) And XMLStatus(0) = #PB_XML_Success
   NewList ListTest() 
   ExtractXMLList(MainXMLNode(0), ListTest(), #PB_XML_NoCase)
   ForEach ListTest()
      Debug ListTest()
   Next
Else
   Debug XMLError(0)
EndIf





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP