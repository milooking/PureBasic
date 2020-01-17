;***********************************
;迷路仟整理 2019.01.30
;ExtractXMLArray_提取到数组
;***********************************

XmlText$ = "<array><element>1</element><element>10</element><element>100</element></array>"

If ParseXML(0, XmlText$) And XMLStatus(0) = #PB_XML_Success
   Dim DimArray(0) 
   ExtractXMLArray(MainXMLNode(0), DimArray())
   For i = 0 To ArraySize(DimArray())
      Debug DimArray(i)
   Next i
Else
   Debug XMLError(0)
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP