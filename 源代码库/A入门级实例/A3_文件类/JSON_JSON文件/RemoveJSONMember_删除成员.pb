;***********************************
;迷路仟整理 2019.01.30
;RemoveJSONMember_删除成员
;***********************************


Input$ = "{ " + #DQUOTE$ + "x" + #DQUOTE$ + ": 10, " + 
                #DQUOTE$ + "y" + #DQUOTE$ + ": 20, " + 
                #DQUOTE$ + "z" + #DQUOTE$ + ": 30 }"
  
ParseJSON(0, Input$)
RemoveJSONMember(JSONValue(0), "x")
Debug ComposeJSON(0, #PB_JSON_PrettyPrint)



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; EnableXP