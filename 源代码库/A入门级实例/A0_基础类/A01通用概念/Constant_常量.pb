;***********************************
;迷路仟整理 2019.01.29
;Constant_常量
;***********************************


;1.常量用#号表示
;2.常量支持整型,浮点型,也支持字符串,字符串常量后面必须带$,如:  #MyConstant = 123, #MyConstant$ = "123"
;2.PureBasic集成了三大平台的绝大部分常量,在不需要声明的情况下,可以直接使用.如#PI,#WM_MOUSEMOVE

#Miloo = 10     ; 这个是常量,前辍带#
Miloo  = 10     ; 这个是变量

#MyConstant1 = 123
#MyConstant2 = 123.456
#MyConstant$ = "123"

Debug "#MyConstant1  = " + #MyConstant1
Debug "#MyConstant2  = " + #MyConstant2
Debug "#MyConstant$  = " + #MyConstant$
Debug "#PI           = " + #PI
Debug "#WM_MOUSEMOVE = " + #WM_MOUSEMOVE
Debug "#DQUOTE$      = " + #DQUOTE$+"双括号"+#DQUOTE$

Debug ""






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableThread
; EnableXP