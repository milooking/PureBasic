;***********************************
;迷路仟整理 2019.01.30
;CatchJSON_抓取内容
;***********************************

JsonID = CatchJSON(#PB_Any, ?_Bin_Json, ?_End_Json-?_Bin_Json)
If JsonID
   ObjectValue = JSONValue(JsonID)
   If ExamineJSONMembers(ObjectValue)
      While NextJSONMember(ObjectValue)
         Debug JSONMemberKey(ObjectValue) + " = " + GetJSONInteger(JSONMemberValue(ObjectValue))
      Wend
   EndIf
EndIf




DataSection 
_Bin_Json:
   Data.b $7B, $20, $22, $78, $22, $3A, $20, $31, $30, $2C, $20, $22, $79, $22, $3A, $20
   Data.b $32, $30, $2C, $20, $22, $7A, $22, $3A, $20, $33, $30, $20, $7D
_End_Json:
EndDataSection












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP