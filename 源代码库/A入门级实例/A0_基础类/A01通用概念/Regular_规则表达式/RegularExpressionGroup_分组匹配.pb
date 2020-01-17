;***********************************
;迷路仟整理 2019.02.11
;RegularExpressionGroup_分组匹配
;***********************************

;区分大小写
RegularID = CreateRegularExpression(#PB_Any, "color=(red|green|blue)")
If RegularID
   If ExamineRegularExpression(RegularID, "stype=bold, color=blue, margin=50")
      While NextRegularExpressionMatch(RegularID)
         Debug "color= " + RegularExpressionGroup(RegularID, 1)
      Wend
   EndIf
Else
   Debug RegularExpressionError()
EndIf



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableThread
; EnableXP