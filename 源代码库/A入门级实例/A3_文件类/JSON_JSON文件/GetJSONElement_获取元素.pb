;***********************************
;迷路仟整理 2019.01.30
;GetJSONElement_获取元素
;***********************************

;【获取布尔值】
ParseJSON(0, "[true, true, false]")
Debug GetJSONBoolean(GetJSONElement(JSONValue(0), 0))
Debug GetJSONBoolean(GetJSONElement(JSONValue(0), 1))
Debug GetJSONBoolean(GetJSONElement(JSONValue(0), 2))


;【获取长整型数值】
ParseJSON(1, "[1, 2, 3, 4, 5]")
For i = 0 To JSONArraySize(JSONValue(1)) - 1
   Debug GetJSONQuad   (GetJSONElement(JSONValue(1), i))
Next

;【获取整型数值】
ParseJSON(2, "[1, 2, 3, 4, 5]")
For i = 0 To JSONArraySize(JSONValue(2)) - 1
   Debug GetJSONInteger(GetJSONElement(JSONValue(2), i))
Next

;【获取双精浮点值】
ParseJSON(3, "[1, 1.23, 1.23e-3]")
Debug GetJSONDouble(GetJSONElement(JSONValue(3), 0))
Debug GetJSONDouble(GetJSONElement(JSONValue(3), 1))
Debug GetJSONDouble(GetJSONElement(JSONValue(3), 2))

;【获取单精浮点值】
ParseJSON(4, "[1, 1.23, 1.23e-3]")
Debug GetJSONFloat(GetJSONElement(JSONValue(4), 0))
Debug GetJSONFloat(GetJSONElement(JSONValue(4), 1))
Debug GetJSONFloat(GetJSONElement(JSONValue(4), 2))

;【获取字符串】
ParseJSON(5, #DQUOTE$ + "欢迎使用[迷路PureBasic实例库工具]" + #DQUOTE$)
Debug GetJSONString(JSONValue(5))  







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 40
; FirstLine = 9
; EnableXP