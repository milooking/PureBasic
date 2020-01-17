;***********************************
;迷路仟整理 2019.01.27
;For_Next 循环
;***********************************

; For <variable> = <expression1> To <expression2> [Step <constant>]
;   ...
; Next [<variable>]
; 注意: For 中的变量,均视为整型, Step后面只能带常量,



;【正序循环】
Debug "正序循环"
For k = 1 To 5 
   Debug k
Next

;【逆序循环】
Debug ""
Debug "逆序循环"
For k = 5 To 1 Step -1
   Debug k
Next

;【步进循环】
Debug ""
Debug "步进循环"
For k = 1 To 10 Step 2
   Debug k
Next

;【Next标识不影响结果,但必须是对应层的变量】
Debug ""
Debug "Next标识不影响结果"
For k = 1 To 5 
   Debug k
Next k


;【浮点数值如自动转换成整型数值】
Debug ""
Debug "浮点数值如自动转换成整型数值"
For k = 1.5 To 10.5 
   Debug k
Next

;【嵌套循环,常用于多维数组或图像像素点操作,支持多层嵌套循环
Debug ""
Debug "嵌套循环"
For x=0 To 2 
   For y=0 To 2
      Debug "x: " + x + " y: " + y
   Next y
Next x


;【For上下限支持变量】
Debug ""
Debug "For上下限支持变量"
a = 2
b = 3 
For k = a+2 To b+7 Step 2
   Debug k
Next 


;【For Next内部对变量进行调整时,注意造成死循环】
Debug ""
For k = 1 To 10
   Debug k
   ;k-1  ;此行会造成死循环,建议循环内部尽量避免修改变量值
Next 

; 【循环正常运行,变量为上限值+1】
Debug ""
Debug "循环正常运行,变量为上限值+1"
For k = 1 To 10
Next 
Debug "上限值=10"
Debug "k=" + k


;【中断退出的循环,变量为中断时的值】
Debug ""
Debug "循环正常运行,变量为上限值+1"
For k = 1 To 10
   If k = 5 : Break : EndIf 
Next 
Debug "上限值=10"
Debug "k=" + k







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 92
; FirstLine = 72
; EnableXP