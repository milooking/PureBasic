;***********************************
;迷路仟整理 2019.01.30
;InsertXMLArray_插入数组
;***********************************

;【一维数组】
; <array>
;   <element>红</element>
;   <element>绿</element>
;   <element>蓝</element>
; </array>
;
Dim DimColor$(2)
DimColor$(0) = "红"
DimColor$(1) = "绿"
DimColor$(2) = "蓝"

If CreateXML(0)
   InsertXMLArray(RootXMLNode(0), DimColor$())
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf

;【多维数组】
; <array>
;   <element a="0" b="0">0</element>
;   <element a="0" b="1">1</element>
;   <element a="1" b="0">10</element>
;   <element a="1" b="1">11</element>
;   <element a="2" b="0">20</element>
;   <element a="2" b="1">21</element>
; </array>
;
Dim DimMulti(2, 1)
For a = 0 To 2
   For b = 0 To 1
      DimMulti(a, b) = a * 10 + b
   Next b
Next a

If CreateXML(0)
   InsertXMLArray(RootXMLNode(0), DimMulti())
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 44
; FirstLine = 15
; EnableXP