;***********************************
;迷路仟整理 2019.01.30
;ExtractXMLMap_提取到映射
;***********************************

XmlText$ = "<map><element key=" + #DQUOTE$ + "theKey" + #DQUOTE$ + ">the value</element></map>"

If ParseXML(0, XmlText$) And XMLStatus(0) = #PB_XML_Success
   NewMap MapTest$() 
   ExtractXMLMap(MainXMLNode(0), MapTest$())
   ForEach MapTest$()
      Debug MapKey(MapTest$()) + " -> " + MapTest$()
   Next
Else
   Debug XMLError(0)
EndIf





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP