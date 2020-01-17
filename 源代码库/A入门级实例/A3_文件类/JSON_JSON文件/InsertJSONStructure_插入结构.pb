;***********************************
;迷路仟整理 2019.01.30
;InsertJSONMap_插入映射
;***********************************

Structure __PersonInfo
   FirstName$
   LastName$
   Age.l
   List ListBook$()
EndStructure
  
Define Person.__PersonInfo
Person\FirstName$ = "John"
Person\LastName$  = "Smith"
Person\Age        = 42
AddElement(Person\ListBook$()): Person\ListBook$() = "Investing For Dummies"
AddElement(Person\ListBook$()): Person\ListBook$() = "English Grammar For Dummies"
AddElement(Person\ListBook$()): Person\ListBook$() = "A Little Bit of Everything For Dummies"

If CreateJSON(0)
   InsertJSONStructure(JSONValue(0), @Person, __PersonInfo)
   Debug ComposeJSON(0, #PB_JSON_PrettyPrint)
EndIf










; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; FirstLine = 1
; Folding = -
; EnableXP