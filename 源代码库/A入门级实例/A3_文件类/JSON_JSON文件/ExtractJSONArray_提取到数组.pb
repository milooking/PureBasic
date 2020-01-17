;***********************************
;迷路仟整理 2019.01.30
;ExtractJSONArray_提取到数组
;***********************************
;【一维数组】
JsonID = ParseJSON(#PB_Any, "[1, 3, 5, 7, 9]")
Dim DimValue(0)
If JsonID
   ExtractJSONArray(JSONValue(JsonID), DimValue())
   For i = 0 To ArraySize(DimValue())
      Debug "DimValue("+Str(i)+") = " + DimValue(i)
   Next
EndIf 

;【多维数组】
JsonID = ParseJSON(#PB_Any, "[[0, 1, 2], [3, 4, 5], [6, 7, 8]]")
Dim DimArray(0, 0)

If JsonID
   ExtractJSONArray(JSONValue(JsonID), DimArray())
   For x = 0 To 2
      For y = 0 To 2
         Debug "DimArray("+Str(x)+","+Str(y)+") = " +  DimArray(x, y)
      Next
   Next
EndIf 





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP