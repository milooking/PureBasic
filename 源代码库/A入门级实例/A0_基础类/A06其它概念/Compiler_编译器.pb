;***********************************
;迷路仟整理 2019.01.29
;Compiler_编译器
;***********************************


;【显式模式】
EnableExplicit    ;启用变量必须先声明的要求
DisableExplicit   ;禁用变量必须先声明的要求

;【内联汇编模式】
EnableASM         ;启用内联汇编
DisableASM        ;禁用内联汇编

;【编译器判断】
; CompilerIf <constant expression>
;   ...
; [CompilerElseIf]
;   ...
; [CompilerElse]
;   ...
; CompilerEndIf


CompilerIf #PB_Compiler_OS = #PB_OS_Linux 
   ;这里是Linux系统下的代码
CompilerElseIf #PB_Compiler_OS = #PB_OS_Windows
   ;这里是Windows系统下的代码
CompilerEndIf


;【编译器选择】
; CompilerSelect <numeric constant>
;   CompilerCase <numeric constant>
;     ...
;   [CompilerDefault]
;     ...
; CompilerEndSelect

CompilerSelect #PB_Compiler_OS
   CompilerCase #PB_OS_MacOS
      ;这里是MacOS系统下的代码
   CompilerCase #PB_OS_Linux
      ;这里是Linux系统下的代码
   CompilerCase #PB_OS_Windows
      ;这里是Windows系统下的代码
CompilerEndSelect


;【编译器警告】
; CompilerError <string constant>     
; CompilerWarning <string constant>  

CompilerIf #PB_Compiler_OS = #PB_OS_Linux
   CompilerError "不支持Linux系统."   
CompilerEndIf


CompilerIf #PB_Compiler_OS = #PB_OS_Linux
   CompilerWarning "不支持Linux系统."
CompilerEndIf

;【编译器常量】
;PureBasic编译器有几个保留的常量
  #PB_Compiler_OS 
    #PB_OS_Windows 
    #PB_OS_Linux   
    #PB_OS_MacOS   

  #PB_Compiler_Processor 
    #PB_Processor_x86     
    #PB_Processor_x64     
  
  #PB_Compiler_ExecutableFormat 
    #PB_Compiler_Executable 
    #PB_Compiler_Console    
    #PB_Compiler_DLL 
           
  #PB_Compiler_Date     
  #PB_Compiler_File     
  #PB_Compiler_FilePath 
  #PB_Compiler_Filename 
  #PB_Compiler_Line     
  #PB_Compiler_Procedure
  #PB_Compiler_Module   
  #PB_Compiler_Version  
  #PB_Compiler_Home     
  #PB_Compiler_Debugger 
  #PB_Compiler_Thread   
  #PB_Compiler_Unicode  
  #PB_Compiler_LineNumbering 
  #PB_Compiler_InlineAssembly
  #PB_Compiler_EnableExplicit
  #PB_Compiler_IsMainFile    
  #PB_Compiler_IsIncludeFile 







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP