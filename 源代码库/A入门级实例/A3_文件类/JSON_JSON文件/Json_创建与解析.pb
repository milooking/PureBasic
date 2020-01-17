;***********************************
;迷路仟整理 2019.01.30
;Json_创建与解析.pb
;***********************************


#jsonCreate = 0
#jsonParser = 1

;【创建JSON】
If CreateJSON(#jsonCreate)
   Person = SetJSONObject(JSONValue(#jsonCreate))
   SetJSONString (AddJSONMember(Person, "姓"), "花")
   SetJSONString (AddJSONMember(Person, "名"), "千骨")
   SetJSONInteger(AddJSONMember(Person, "年龄"), 15)
   Attribute = SetJSONArray(AddJSONMember(Person, "属性"))
   For i = 1 To 5
      SetJSONInteger(AddJSONElement(Attribute), Random(256))
   Next i
   Debug "---------- 紧凑格式 ----------"
   Debug ""
   Debug ComposeJSON(#jsonCreate)
   Debug ""
   Debug "---------- 对齐格式 ----------"
   Debug ""
   Debug ComposeJSON(#jsonCreate, #PB_JSON_PrettyPrint)
   Debug ""
EndIf

;【解析JSON】
Input$ = "[1, 3, 5, 7, null, 23, 25, 27]"
If ParseJSON(#jsonParser, Input$)
   NewList Numbers()
   ExtractJSONList(JSONValue(#jsonParser), Numbers())
   Debug "---------- 提取值 ----------"
   Debug ""
   ForEach Numbers()
      Debug Numbers()
    Next 
EndIf



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP