;***********************************
;迷路仟整理 2019.01.30
;CreateJSON_创建JSON
;***********************************

JsonID = CreateJSON(#PB_Any)
If JsonID
   Person = SetJSONObject(JSONValue(JsonID))
   SetJSONString (AddJSONMember(Person, "姓"), "花")
   SetJSONString (AddJSONMember(Person, "名"), "千骨")
   SetJSONInteger(AddJSONMember(Person, "年龄"), 15)
   Debug ComposeJSON(JsonID, #PB_JSON_PrettyPrint)
EndIf











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; EnableXP