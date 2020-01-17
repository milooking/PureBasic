;***********************************
;迷路仟整理 2019.01.30
;ExtractXMLStructure_提取到结构体
;***********************************

Structure __PersonInfo
   Name$
   Age.l
EndStructure
  
XmlText$ = "<Person><Name>花千骨</Name><Age>15</Age></Person>"

If ParseXML(0, XmlText$) And XMLStatus(0) = #PB_XML_Success
   Define Person.__PersonInfo
   ExtractXMLStructure(MainXMLNode(0), @Person, __PersonInfo)
   Debug Person\Name$
   Debug Person\Age
Else
   Debug XMLError(0)
EndIf 






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP