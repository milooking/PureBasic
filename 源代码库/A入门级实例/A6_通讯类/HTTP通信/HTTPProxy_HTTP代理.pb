;***********************************
;迷路仟整理 2019.01.26
;HTTPProxy_HTTP代理
;***********************************

InitNetwork()

HTTPProxy("socks4://127.0.0.1")
FileName$ = SaveFileRequester("保存index.php", "", "", 0)
If ReceiveHTTPFile("http://www.purebasic.com/index.php", FileName$)
   Debug "成功"
Else
   Debug "失败"
EndIf




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP