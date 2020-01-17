;***********************************
;迷路仟整理 2019.01.26
;RunProgram_调用程序
;***********************************

;
;运行PureBasic编译器
CompilerID = RunProgram(#PB_Compiler_Home+"/Compilers/pbcompiler", "/?", "", #PB_Program_Open|#PB_Program_Read)
txtOutput$ = ""
If CompilerID
   ;获取PureBasic编译器中的运行命令
   While ProgramRunning(CompilerID)
      If AvailableProgramOutput(CompilerID)
         txtOutput$ + ReadProgramString(CompilerID) + #LF$
      EndIf
   Wend
   txtOutput$ + Chr(13) + Chr(13)
   txtOutput$ + "退出代码: " + Str(ProgramExitCode(CompilerID))
   CloseProgram(CompilerID) ; 关闭程序
EndIf

MessageRequester("显示", txtOutput$)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP