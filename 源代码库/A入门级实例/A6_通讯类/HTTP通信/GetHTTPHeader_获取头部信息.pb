;***********************************
;迷路仟整理 2019.01.26
;GetHTTPHeader_获取头部信息
;***********************************

InitNetwork()

Header$ = GetHTTPHeader("http://www.purebasic.com/index.php")

Repeat
   Index+1
   Line$ = StringField(Header$, Index, #LF$)
   Debug Line$
Until Line$ = ""


;演示结果
; HTTP/1.1 301 Moved Permanently
; Date: Sat, 26 Jan 2019 15:06:44 GMT
; Server: Apache/2.4.10 (Debian)
; Location: https://www.purebasic.com/index.php
; Content-Type: text/html; charset=iso-8859-1
; 
; HTTP/1.1 200 OK
; Date: Sat, 26 Jan 2019 15:06:46 GMT
; Server: Apache/2.4.10 (Debian)
; Content-Type: text/html

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP