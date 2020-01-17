;***********************************
;迷路仟整理 2019.01.30
;JSONType_获取类型
;***********************************

Procedure.s GetAnyValue(Value)
   Select JSONType(Value)
      Case #PB_JSON_Null:    ProcedureReturn "null"
      Case #PB_JSON_String:  ProcedureReturn GetJSONString(Value)
      Case #PB_JSON_Number:  ProcedureReturn StrD(GetJSONDouble(Value))    
      Case #PB_JSON_Boolean: ProcedureReturn Str(GetJSONBoolean(Value))
      Case #PB_JSON_Array:   ProcedureReturn "array"
      Case #PB_JSON_Object:  ProcedureReturn "object"
   EndSelect
EndProcedure
  
ParseJSON(0, "[1, 2, true, null, " + #DQUOTE$ + "hello" + #DQUOTE$ + "]")
For i = 0 To JSONArraySize(JSONValue(0)) - 1
 Debug GetAnyValue(GetJSONElement(JSONValue(0), i))
Next i







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; Folding = -
; EnableXP