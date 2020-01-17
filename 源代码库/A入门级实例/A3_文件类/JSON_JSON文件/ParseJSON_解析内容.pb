;***********************************
;迷路仟整理 2019.01.30
;ParseJSON_解析内容
;***********************************


If ParseJSON(0, "[1, 2, 3, 4, 5]")    
   For i = 0 To JSONArraySize(JSONValue(0)) - 1
      Debug GetJSONInteger(GetJSONElement(JSONValue(0), i))
   Next i
Else
   JSONErrorMessage()
EndIf







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; EnableXP