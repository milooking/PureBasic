;***********************************
;迷路仟整理 2019.01.30
;InsertXMLMap_插入映射
;***********************************


; <map>
;   <element key="KOR">韩国</element>
;   <element key="CHI">中国</element>
;   <element key="JPN">日本</element>
; </map>

;
NewMap MapCountry$()
MapCountry$("CHI") = "中国"
MapCountry$("KOR") = "韩国"  
MapCountry$("JPN") = "日本"

If CreateXML(0)
   InsertXMLMap(RootXMLNode(0), MapCountry$())
   FormatXML(0, #PB_XML_ReFormat)
   Debug ComposeXML(0)
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP