;***********************************
;迷路仟整理 2019.01.26
;Environment_程序运行环境
;***********************************


OpenConsole()        ;打开控制台
If ExamineEnvironmentVariables()       ;检测程序的运行环境
   While NextEnvironmentVariable()
      Text$ = EnvironmentVariableName() + " = " + EnvironmentVariableValue()
      PrintN(Text$)  ;输出文本到控制台,PrintN带换行,Print不带换行
   Wend
EndIf
PrintN("")
Result$ = GetEnvironmentVariable("PATH") ;从程序环境块返回指定环境变量的内容。
PrintN(Result$)
PrintN("")
PrintN("按[回车键]退出.")
Input()

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP
; EnableOnError