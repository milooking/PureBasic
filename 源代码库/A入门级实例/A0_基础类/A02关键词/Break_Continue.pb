;***********************************
;迷路仟整理 2019.01.27
;Break_Continue
;***********************************

;【简单实例】
Debug "简单实例"
For k = 0 To 10
   If k=5
      Break  ; 循环到这里就退出
   EndIf
   Debug k
Next

;【嵌套实例1】
Debug ""
Debug "嵌套实例1"
Count = 0
For i = 1 To 10
   For j = 1 To 3
      Count+1
      If Count >= 13
         Break ; 满足Count>=13时,直接退出单层循环
      EndIf
      Debug Count
   Next 
Next
Debug "i = "+Str(i)
Debug "j = "+Str(j)

;【嵌套实例2】
Debug ""
Debug "嵌套实例2"
Count = 0
For i = 1 To 10
   For j = 1 To 3
      Count+1
      If Count >= 13
         Break 2 ; 满足Count>=13时,直接退出两层循环
      EndIf
      Debug Count
   Next 
Next
Debug "i = "+Str(i)
Debug "j = "+Str(j)


;【跳过实例】
Debug ""
Debug "跳过实例"
Count = 0
For i = 1 To 10
   If i % 2 = 0      ;逢双就跳过
      Continue
   EndIf  
   Debug i
Next













; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; FirstLine = 16
; EnableXP