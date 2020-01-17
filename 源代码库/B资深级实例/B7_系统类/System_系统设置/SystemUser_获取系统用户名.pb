;***********************************
;迷路仟整理 2019.03.15
;SystemUser_获取系统用户名
;***********************************


Bufsize = 1024 
Buffer$ = Space(Bufsize) 

GetComputerName_(@Buffer$, @Bufsize) 
Debug "计算机名称: "+Buffer$

GetUserName_(@Buffer$, @Bufsize) 
Debug "用 户 名称: "+Buffer$


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP
; EnableOnError