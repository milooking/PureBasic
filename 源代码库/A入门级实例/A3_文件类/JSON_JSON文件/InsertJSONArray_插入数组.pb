;***********************************
;迷路仟整理 2019.01.30
;InsertJSONArray_插入数组
;***********************************


;【一维数组】
Dim DimColors$(3)
DimColors$(0) = "红"
DimColors$(1) = "黄"
DimColors$(2) = "绿"
DimColors$(3) = "蓝"

If CreateJSON(0)
   InsertJSONArray(JSONValue(0), DimColors$())
   Debug ComposeJSON(0)
EndIf


;【多维数组】
Dim DimMatrix(2, 2)
DimMatrix(0, 0) = 1
DimMatrix(1, 1) = 1
DimMatrix(2, 2) = 1

If CreateJSON(1)
   InsertJSONArray(JSONValue(1), DimMatrix())
   Debug ComposeJSON(1)
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP