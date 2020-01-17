;***********************************
;迷路仟整理 2019.01.26
;Assembly_反汇编实例
;***********************************

   DisableDebugger    ; 禁用调试模式
   Code_Start:
      ;这里放着反汇编的目标代码
      Value = (Random(100) * 5) + 2000
   Code_End:
   
   Text$ = "反汇编代码: " + #LF$ 
   If ExamineAssembly(?Code_Start, ?Code_End)
      While NextInstruction()
         Text$ + "0x"  + RSet(Hex(InstructionAddress()), SizeOf(Integer)*2, "0")
         Text$ + " : " + InstructionString() + #LF$ 
      Wend
   EndIf
   
   MessageRequester("反汇编结果", Text$)


; IDE Options = PureBasic 5.62 (Windows - x86)
; EnableXP
; EnableOnError