;***********************************
;迷路仟整理 2019.02.11
;CreateRegularExpression_创建规则
;***********************************

;区分大小写
RegularID = CreateRegularExpression(#PB_Any, "[a-z]b[A-Z]")
If RegularID
   Debug MatchRegularExpression(RegularID, "abC") ; 显示 1
   Debug MatchRegularExpression(RegularID, "abc") ; 显示 0
Else
   Debug RegularExpressionError()
EndIf




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableThread
; EnableXP