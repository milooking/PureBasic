;***********************************
;迷路仟整理 2019.01.30
;ResizeJSONElements_调整元素
;***********************************

ParseJSON(0, "[1, 2, 3, 4, 5]") 
ResizeJSONElements(JSONValue(0), 3)
Debug ComposeJSON(0)
  
ResizeJSONElements(JSONValue(0), 10)
Debug ComposeJSON(0)



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP