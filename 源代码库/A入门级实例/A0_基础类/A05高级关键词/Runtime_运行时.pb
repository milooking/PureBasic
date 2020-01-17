;***********************************
;迷路仟整理 2019.01.28
;Pseudotype_伪类型
;***********************************

 
; Runtime Variable
; Runtime #Constant
; Runtime Procedure() declaration
; Runtime Enumeration declaration

;【函数】
Runtime Procedure OnEvent()
   Debug "OnEvent"
EndProcedure 

Debug GetRuntimeInteger("OnEvent()") 


;【常量】
Runtime Enumeration
   #Constant1 = 10
   #Constant2
   #Constant3
EndEnumeration

Debug GetRuntimeInteger("#Constant1")
Debug GetRuntimeInteger("#Constant2")
Debug GetRuntimeInteger("#Constant3")


;【变量】
Define a = 20
Runtime a

Debug GetRuntimeInteger("a")
SetRuntimeInteger("a", 30)

Debug a 



;【调用】

Prototype Function()

Runtime Procedure Function1()
   Debug "调用了Function1()函数"
EndProcedure

Runtime Procedure Function2()
   Debug "调用了Function2()函数"
EndProcedure

Procedure LaunchProcedure(Name.s)
   Protected ProcedureName.Function = GetRuntimeInteger(Name + "()")
   ProcedureName()
EndProcedure

LaunchProcedure("Function1") ; 调用了Function1()函数"
LaunchProcedure("Function2") ; 调用了Function2()函数"
  


Runtime Procedure Runtime_Test() 
  Debug "Runtime函数"
EndProcedure

Debug "Runtime_Test()地址: 0x" + GetRuntimeInteger("Runtime_Test()")

Variable.i = 128
Runtime Variable
Debug "变量: " + GetRuntimeInteger("Variable")

SetRuntimeInteger("Variable", 256)

; 内部变量值已更改
Debug "Runtime变量: " + Variable





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 59
; FirstLine = 46
; Folding = --
; EnableXP