;***********************************
;迷路仟整理 2019.01.26
;URLEncoder_链接编码
;***********************************

URL$ = "https://www.baidu.com/s?wd=%E8%BF%B7%E8%B7%AF%E4%BB%9F"
Result$ = URLDecoder(URL$)
Debug Result$

Result$ = URLEncoder(Result$)
Debug Result$



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP