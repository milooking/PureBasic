;***********************************
;迷路仟整理 2019.01.29
;String_字符串
;***********************************

;   #DQUOTE$  ; 这个是字符串类型的双引号"
;   #Null$    ; 这个是字符串类型的空值
;   #Null     ; 这个是数值 0

Text.s =  "Hello world"  ; 字符串定义与赋值
Text$  = "PureBasic!"    ; 字符串定义与赋值,注意Text.s和Text$是两个不同的变量

Format$ = ~"Escape\nMe !" ;格式文本,前面要加~
Debug "Format$ = " + Format$

;当字符串,可以分行编写,但后面要加连接符 "+"
Format$ = "这种语言相当的简单,但提供了很多高级的用法,"+
          "如指针,结构,过程,动态链表等等.对于有经验的程序员,"+
          "可以在无须声明的情况下,使用任意的系统结构或Window API函数."
Debug "Format$ = " + Format$

;或者用变量连接法,  Format$ + "如..." 相当于 Format$ = Format$ + "如..."
Format$ = "这种语言相当的简单,但提供了很多高级的用法,"
Format$ + "如指针,结构,过程,动态链表等等.对于有经验的程序员,"
Format$ + "可以在无须声明的情况下,使用任意的系统结构或Window API函数."
Debug "Format$ = " + Format$

;〖换行符〗
;CHR表示法: Chr(10), Chr(13), Chr(10)+Chr(13), Chr(13)+Chr(12)
;常量表示法: #LF$, #CR$, #LF$+#CR$, #LFCR$, #CR$+#LF$, #CRLF$
;格式文本法

Format$ = ~"这种语言相当的简单,\n但提供了很多高级的用法,"
Debug "Format$ = " + Format$

Format$ = ~"这种语言相当的简单,\n但提供了很多高级的用法,\n"+
          ~"如指针,结构,过程,动态链表等等.\n对于有经验的程序员,\n"+
          ~"可以在无须声明的情况下,\n使用任意的系统结构或Window API函数.\n"
Debug "Format$ = " + Format$












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableThread
; EnableXP