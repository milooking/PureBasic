;***********************************
;迷路仟整理 2019.01.28
;其它
;***********************************

; Goto <label>

; End [ExitCode]

; Swap <expression>, <expression>

   ;实例1
   A = 1
   B = 2
   Swap A, B
   Debug "变量交换内容后:"
   Debug "A = " + A
   Debug "B = " + B


   ;实例2
   Dim Array1(5,5) 
   Dim Array2(5,5) 
   Array1(2,2) = 10   
   Array2(3,3) = 20
   
   Debug "Array1=" + Array1(2,2) 
   Debug "Array2=" + Array2(3,3) 
   
   Swap Array1(2,2) , Array2(3,3) 
   
   Debug "数组成员交换内容后:"
   Debug "Array1=" + Array1(2,2)  
   Debug "Array2=" + Array2(3,3) 








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP