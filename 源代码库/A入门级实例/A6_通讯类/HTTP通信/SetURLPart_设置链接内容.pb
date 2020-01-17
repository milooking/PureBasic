;***********************************
;迷路仟整理 2019.01.26
;SetURLPart_设置链接内容
;***********************************

URL$ = "http://www.baidu.com"
URL$ = SetURLPart(URL$, #PB_URL_Protocol, "ftp")
URL$ = SetURLPart(URL$, #PB_URL_Site, "www.purebasic.com")
URL$ = SetURLPart(URL$, #PB_URL_Port, "80")
URL$ = SetURLPart(URL$, #PB_URL_Path, "english/index.php3")
URL$ = SetURLPart(URL$, #PB_URL_User, "user")
URL$ = SetURLPart(URL$, #PB_URL_Password, "pass")
URL$ = SetURLPart(URL$, "test", "1")
URL$ = SetURLPart(URL$, "ok", "2")

Debug URL$ 

;ftp://user:pass@www.purebasic.com:80/english/index.php3?test=1&ok=2




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; EnableXP