;***********************************
;迷路仟整理 2019.01.30
;ExtractJSONMap_提取到映射
;***********************************

Input$ = ~"{\"enabled\": 1, \"displayed\": 1, \"visible\": 0 }"   
Debug Input$

NewMap MapOption()
  
JsonID = ParseJSON(#PB_Any, Input$)
If JsonID
   ExtractJSONMap(JSONValue(JsonID), MapOption())       
   Debug MapOption("enabled")
   Debug MapOption("visible")
EndIf 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableXP