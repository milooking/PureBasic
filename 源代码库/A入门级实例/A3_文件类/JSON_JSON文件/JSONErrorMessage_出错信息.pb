;***********************************
;迷路仟整理 2019.01.30
;JSONErrorMessage_出错信息
;***********************************

If ParseJSON(0, "[1, 2, 3 4]")
   Debug "正常!"
Else
   Debug JSONErrorMessage()
EndIf











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP