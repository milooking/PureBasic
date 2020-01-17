;***********************************
;迷路仟整理 2019.01.28
;If_Else_EndIf 判断
;***********************************

; If <expression> 
;   ...
; [ElseIf <expression>]
;   ...
; [Else]  ;其它条件
;   ...
; EndIf 

;【基本用法】
Value = 5
If Value = 10 
   Debug "Value = 10"
Else
   Debug "Value <> 10"
EndIf    


;【嵌套用法】
b = 15
If a = 10 And b >= 10 Or c = 20     
   If b = 15
      Debug "b = 15"
   Else       
      Debug "其它可能"
   EndIf   
Else     
   Debug "测试失败"
EndIf  


;【布尔判断】
a = 10
b = 11
c = 12
d = Bool(a=b And a=c)
If d = #True
   Debug "测试成功"
Else     
   Debug "测试失败"
EndIf  



;【调用判断】
Procedure DisplayHello()
   Debug "Hello"
   ProcedureReturn 1
EndProcedure

a = 10
If a = 10 Or DisplayHello() = 1 
   Debug "测试成功"
Else     
   Debug "测试失败"
EndIf  







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 40
; Folding = -
; EnableXP