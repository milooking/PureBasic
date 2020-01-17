;***********************************
;迷路仟整理 2019.01.26
;OnError_出错捕获实例
;***********************************


Procedure Error_Handler()
   
   ErrorMessage$ = "项目出错检测:" + #LF$ 
   ErrorMessage$ + #LF$
   ErrorMessage$ + "错误信息: " + ErrorMessage()      + #LF$
   ErrorMessage$ + "错误代码: 0x" + Hex(ErrorCode(), #PB_Long)    + #LF$  
   ErrorMessage$ + "错误位置: 0x" + Hex(ErrorAddress(), #PB_Long) + #LF$
 
   If ErrorCode() = #PB_OnError_InvalidMemory   
      ErrorMessage$ + "目标地址:  " + Str(ErrorTargetAddress()) + #LF$
   EndIf
 
   If ErrorLine() = -1
      ErrorMessage$ + "源代码行: 启用OnError行支持以获取代码行信息." + #LF$
   Else
      ErrorMessage$ + "源代码行: " + Str(ErrorLine()) + #LF$
      ErrorMessage$ + "代码文件: " + ErrorFile() + #LF$
   EndIf
 
   ErrorMessage$ + #LF$
   ErrorMessage$ + "寄存器信息:" + #LF$
 
   CompilerSelect #PB_Compiler_Processor 
      CompilerCase #PB_Processor_x86
         ErrorMessage$ + "EAX = " + Str(ErrorRegister(#PB_OnError_EAX)) + #LF$
         ErrorMessage$ + "EBX = " + Str(ErrorRegister(#PB_OnError_EBX)) + #LF$
         ErrorMessage$ + "ECX = " + Str(ErrorRegister(#PB_OnError_ECX)) + #LF$
         ErrorMessage$ + "EDX = " + Str(ErrorRegister(#PB_OnError_EDX)) + #LF$
         ErrorMessage$ + "EBP = " + Str(ErrorRegister(#PB_OnError_EBP)) + #LF$
         ErrorMessage$ + "ESI = " + Str(ErrorRegister(#PB_OnError_ESI)) + #LF$
         ErrorMessage$ + "EDI = " + Str(ErrorRegister(#PB_OnError_EDI)) + #LF$
         ErrorMessage$ + "ESP = " + Str(ErrorRegister(#PB_OnError_ESP)) + #LF$
 
      CompilerCase #PB_Processor_x64
         ErrorMessage$ + "RAX = " + Str(ErrorRegister(#PB_OnError_RAX)) + #LF$
         ErrorMessage$ + "RBX = " + Str(ErrorRegister(#PB_OnError_RBX)) + #LF$
         ErrorMessage$ + "RCX = " + Str(ErrorRegister(#PB_OnError_RCX)) + #LF$
         ErrorMessage$ + "RDX = " + Str(ErrorRegister(#PB_OnError_RDX)) + #LF$
         ErrorMessage$ + "RBP = " + Str(ErrorRegister(#PB_OnError_RBP)) + #LF$
         ErrorMessage$ + "RSI = " + Str(ErrorRegister(#PB_OnError_RSI)) + #LF$
         ErrorMessage$ + "RDI = " + Str(ErrorRegister(#PB_OnError_RDI)) + #LF$
         ErrorMessage$ + "RSP = " + Str(ErrorRegister(#PB_OnError_RSP)) + #LF$
         ErrorMessage$ + "跳过寄存器R8-R15的显示."                      + #LF$
 
   CompilerEndSelect
   MessageRequester("OnError实例", ErrorMessage$)
   End
EndProcedure
 

;启用出错捕获
OnErrorCall(@Error_Handler())
 
MessageRequester("OnError实例", "执行代码出现一些错误。Debugger(调试器)自动关闭。")
 
; 写入受保护内存
PokeS(123, "用这种方法来产生一个错误场景.")
 
  
; 除数为0的错误
Value = 0
Value = 1 / Value
 
; 手动生成错误
RaiseError(#PB_OnError_IllegalInstruction)
 
 
; 不应该显示这个
MessageRequester("OnError实例", "代码执行完毕,一切正常.")
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 56
; Folding = +
; EnableXP
; EnableOnError