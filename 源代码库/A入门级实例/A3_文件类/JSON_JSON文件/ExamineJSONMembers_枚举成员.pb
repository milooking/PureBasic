;***********************************
;迷路仟整理 2019.01.30
;ExamineJSONMembers_枚举成员
;***********************************

;写法1
Input$ = "{ " + Chr(34) + "x" + Chr(34) + ": 10, " + 
                Chr(34) + "y" + Chr(34) + ": 20, " + 
                Chr(34) + "z" + Chr(34) + ": 30 }"
                
;写法2
; Input$ = "{ " + #DQUOTE$ + "x" + #DQUOTE$ + ": 10, " + 
;                 #DQUOTE$ + "y" + #DQUOTE$ + ": 20, " + 
;                 #DQUOTE$ + "z" + #DQUOTE$ + ": 30 }"
                
;写法3
; Input$ = "{ 'x': 10, 'y': 20, 'z': 30}"
; Input$ = ReplaceString(Input$, "'", #DQUOTE$)

;写法4
; Input$ = ~"{ \"x\": 10, \"y\": 20, \"z\": 30}"

JsonID = ParseJSON(#PB_Any, Input$)
If JsonID
   ObjectValue = JSONValue(JsonID)
   If ExamineJSONMembers(ObjectValue)
      While NextJSONMember(ObjectValue)
         Debug JSONMemberKey(ObjectValue) + " = " + GetJSONInteger(JSONMemberValue(ObjectValue))
      Wend
   EndIf
EndIf







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 21
; EnableXP