;***********************************
;迷路仟整理 2019.01.30
;SetJSONElement_设置元素
;***********************************

;【设置布尔值】
If CreateJSON(0)
   ArrayValue = SetJSONArray(JSONValue(0))
   SetJSONBoolean(AddJSONElement(ArrayValue), #True)
   SetJSONBoolean(AddJSONElement(ArrayValue), #False)
   Debug ComposeJSON(0)
EndIf

;【设置长整型值】
If CreateJSON(1)
   ArrayValue = SetJSONArray(JSONValue(1))
   SetJSONQuad(AddJSONElement(ArrayValue), 1)
   SetJSONQuad(AddJSONElement(ArrayValue), 2)
   SetJSONQuad(AddJSONElement(ArrayValue), 3)
   Debug ComposeJSON(1)
EndIf

;【设置整型值】
If CreateJSON(2)
   ArrayValue = SetJSONArray(JSONValue(2))
   SetJSONInteger(AddJSONElement(ArrayValue), 1)
   SetJSONInteger(AddJSONElement(ArrayValue), 2)
   SetJSONInteger(AddJSONElement(ArrayValue), 3)
   Debug ComposeJSON(2)
EndIf


;【设置双精浮点值】
If CreateJSON(3)
   ArrayValue = SetJSONArray(JSONValue(3))
   SetJSONDouble(AddJSONElement(ArrayValue), 1.23)
   SetJSONDouble(AddJSONElement(ArrayValue), 4.56)
   Debug ComposeJSON(3)
EndIf

;【设置单精浮点值】
If CreateJSON(4)
   ArrayValue = SetJSONArray(JSONValue(4))
   SetJSONFloat(AddJSONElement(ArrayValue), 1.23)
   SetJSONFloat(AddJSONElement(ArrayValue), 4.56)
   Debug ComposeJSON(4)
EndIf

;【设置字符串】
If CreateJSON(5)
   ArrayValue = SetJSONArray(JSONValue(5))
   SetJSONString(AddJSONElement(ArrayValue), "with escaped new" + Chr(13) + Chr(10) + "line")
   SetJSONString(AddJSONElement(ArrayValue), "with escaped \ backslash")
   Debug ComposeJSON(5)
EndIf

;【设置空值】
ParseJSON(6, "[1, 2, 3, 4, 5]") 
SetJSONNull(GetJSONElement(JSONValue(6), 2))
SetJSONNull(GetJSONElement(JSONValue(6), 3))
Debug ComposeJSON(6)


;【设置数组】
If CreateJSON(7)
   ArrayValue = SetJSONArray(JSONValue(7))
   SetJSONString(AddJSONElement(ArrayValue), "花千骨")
   SetJSONString(AddJSONElement(ArrayValue), "白子画")
   Debug ComposeJSON(7)
EndIf


;【设置数对象】
If CreateJSON(8)
   ObjectValue = SetJSONObject(JSONValue(8))
   SetJSONInteger(AddJSONMember(ObjectValue, "x"), 10)
   SetJSONInteger(AddJSONMember(ObjectValue, "y"), 20)
   SetJSONInteger(AddJSONMember(ObjectValue, "z"), 30)
   Debug ComposeJSON(8, #PB_JSON_PrettyPrint)
EndIf

















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 80
; FirstLine = 55
; EnableXP