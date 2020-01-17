;***********************************
;迷路仟整理 2019.01.30
;AddJSONMember_添加成员
;***********************************

JsonID = CreateJSON(#PB_Any)
If JsonID
    ArrayValue = SetJSONArray(JSONValue(JsonID))
    ;在末端添加元素
    For i = 1 To 5
      NumValue = AddJSONElement(ArrayValue)
      SetJSONInteger(NumValue, i)
    Next i
    ;在指定索引处插入元素
    StrValue = AddJSONElement(ArrayValue, 1)
    SetJSONString(StrValue, "PureBasic")
    Debug ComposeJSON(JsonID)
EndIf














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; EnableXP