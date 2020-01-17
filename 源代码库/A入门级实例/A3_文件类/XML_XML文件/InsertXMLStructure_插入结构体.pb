;***********************************
;迷路仟整理 2019.01.30
;InsertXMLStructure_插入结构体
;***********************************


; <__PersonInfo>
;   <Name>John Smith</Name>
;   <Age>42</Age>
;   <ListBook>
;     <element>Investing For Dummies</element>
;     <element>A Little Bit of Everything For Dummies</element>
;   </ListBook>
; </__PersonInfo>

Structure __PersonInfo
   Name$
   Age.l
   List ListBook$()
EndStructure
  
Define Person.__PersonInfo

Person\Name$ = "John Smith"
Person\Age   = 42
AddElement(Person\ListBook$()) : Person\ListBook$() = "Investing For Dummies"
AddElement(Person\ListBook$()) : Person\ListBook$() = "A Little Bit of Everything For Dummies"

If CreateXML(0)
   InsertXMLStructure(RootXMLNode(0), @Person, __PersonInfo)
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; FirstLine = 1
; Folding = -
; EnableXP