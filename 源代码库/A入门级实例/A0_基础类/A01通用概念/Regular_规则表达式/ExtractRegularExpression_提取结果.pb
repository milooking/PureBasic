;***********************************
;迷路仟整理 2019.02.11
;ExtractRegularExpression_提取结果
;***********************************

RegularID = CreateRegularExpression(#PB_Any, "[a-z]b[a-z]")
If RegularID
   Dim DimResult$(0)
   Result = ExtractRegularExpression(RegularID, " abc it won't match abz", DimResult$())
   Debug "共匹配到的结果: " + Result
   For i = 0 To Result - 1
      Debug DimResult$(i)
   Next
Else
   MessageRequester("出错提示", RegularExpressionError())
EndIf




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableThread
; EnableXP