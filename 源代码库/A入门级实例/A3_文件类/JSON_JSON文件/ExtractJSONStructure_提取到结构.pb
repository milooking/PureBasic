;***********************************
;迷路仟整理 2019.01.30
;ExtractJSONStructure_提取到结构
;***********************************

Structure __PersonInfo
   Name$
   Age.l
   List ListMartial$()
EndStructure

Input$ = "{" + #DQUOTE$ + "Name" + #DQUOTE$ + ":" + #DQUOTE$ + "花千骨" + #DQUOTE$ + ", " + 
               #DQUOTE$ + "Age"  + #DQUOTE$ + ":15, " + 
               #DQUOTE$ + "ListMartial" + #DQUOTE$ + ":["     +
               #DQUOTE$ + "一阳指" + #DQUOTE$ + ","    + 
               #DQUOTE$ + "二阳指" + #DQUOTE$ + "] }"
Debug  Input$    
          
JsonID = ParseJSON(#PB_Any, Input$)
If JsonID
   ExtractJSONStructure(JSONValue(JsonID), @Person.__PersonInfo, __PersonInfo)
   Debug Person\Name$
   Debug Person\Age
   ForEach Person\ListMartial$()
      Debug Person\ListMartial$()
   Next 
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP