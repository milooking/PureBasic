;***********************************
;迷路仟整理 2019.01.26
;URLEncoder_链接编码
;***********************************

InitNetwork()

FileName$ = SaveFileRequester("Where to save index.php ?", "", "", 0)
If ReceiveHTTPFile("http://www.purebasic.com/index.php", FileName$)
   Debug "接收成功"
Else
   Debug "接收失败"
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP