;***********************************
;迷路仟整理 2019.01.30
;ExtractJSONList_提取到链表
;***********************************

Input$ = "[ {'x': 10, 'y': 20}, {'x': 30, 'y': 50}, {'x': -5, 'y': 100} ]"
Input$ = ReplaceString(Input$, "'", #DQUOTE$)

  
  
NewList ListPoint.POINTS()
  
JsonID = ParseJSON(#PB_Any, Input$)
If JsonID
   ExtractJSONList(JSONValue(JsonID), ListPoint())
   ForEach ListPoint()
      Debug Str(ListPoint()\x) + ", " + Str(ListPoint()\y)
   Next
EndIf 






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP