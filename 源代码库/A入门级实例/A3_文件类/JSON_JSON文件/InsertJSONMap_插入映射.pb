;***********************************
;迷路仟整理 2019.01.30
;InsertJSONMap_插入映射
;***********************************

NewMap MapColor()
  MapColor("红") = $0000FF
  MapColor("绿") = $00FF00
  MapColor("蓝") = $FF0000
  
If CreateJSON(0)
   InsertJSONMap(JSONValue(0), MapColor())
   Debug ComposeJSON(0, #PB_JSON_PrettyPrint)
EndIf









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP