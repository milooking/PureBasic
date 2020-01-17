;***********************************
;迷路仟整理 2019.01.30
;ComposeJSON_编辑内容
;***********************************

JsonID = CreateJSON(#PB_Any)
If JsonID
   ObjectValue = SetJSONObject(JSONValue(JsonID))
   
   FirstName = AddJSONMember(ObjectValue, "姓")
   SetJSONString(FirstName, "花")
   
   LastName = AddJSONMember(ObjectValue, "名")
   SetJSONString(LastName, "千骨")   
    
   Debug ComposeJSON(JsonID)
EndIf














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP