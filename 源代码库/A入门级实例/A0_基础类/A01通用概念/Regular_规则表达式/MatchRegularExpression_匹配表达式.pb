;***********************************
;迷路仟整理 2019.02.11
;MatchRegularExpression_匹配表达式
;***********************************

;区分大小写
RegularID = CreateRegularExpression(#PB_Any, "[a-z]b[A-Z]")
If RegularID
   If MatchRegularExpression(RegularID, "abC ABc zbA abc")
      Debug "匹配成功!"
   Else
      Debug "没有匹配到!"
   EndIf
Else
   Debug RegularExpressionError()
EndIf



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableThread
; EnableXP