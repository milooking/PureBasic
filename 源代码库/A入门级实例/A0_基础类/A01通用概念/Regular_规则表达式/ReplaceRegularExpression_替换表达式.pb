;***********************************
;迷路仟整理 2019.02.11
;ReplaceRegularExpression_替换表达式
;***********************************

;区分大小写
RegularID = CreateRegularExpression(#PB_Any, "[a-z]b[A-Z]")
If RegularID
   Result$ = ReplaceRegularExpression(RegularID, "abC ABc zbA abc", "---")
   Debug Result$        ;"--- ABc --- abc"
Else
   Debug RegularExpressionError()
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableThread
; EnableXP