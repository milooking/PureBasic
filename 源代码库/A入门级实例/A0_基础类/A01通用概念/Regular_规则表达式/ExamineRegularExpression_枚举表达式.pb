;***********************************
;迷路仟整理 2019.02.11
;ExamineRegularExpression_枚举表达式
;***********************************

;区分大小写
RegularID = CreateRegularExpression(#PB_Any, "[a-z]b[A-Z]")
If RegularID
   If ExamineRegularExpression(RegularID, "abC ABc zbA abc")
      While NextRegularExpressionMatch(RegularID)
         Debug "区配: " + RegularExpressionMatchString(RegularID)
         Debug "    位置: " + Str(RegularExpressionMatchPosition(RegularID))
         Debug "    长度: " + Str(RegularExpressionMatchLength(RegularID))
      Wend
   EndIf
Else
   Debug RegularExpressionError()
EndIf



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableThread
; EnableXP