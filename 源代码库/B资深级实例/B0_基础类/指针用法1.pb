;***********************************
;迷路仟整理 2019.03.22
;指针用法1
;***********************************



; 【1.用来表示内存块】
*pMemData = AllocateMemory(1000)

; 【2.用来指向变量】
Value = $55667788
*pValueL.Long  = @Value  : Debug Hex(*pValueL\l) ;用一个LONG型指针指向变量Value
*pValueW.Word  = @Value  : Debug Hex(*pValueW\w) ;用一个WORD型指针指向变量Value
*pValueB.Byte  = @Value  : Debug *pValueB\b      ;用一个BYTE型指针指向变量Value
*pValueA.Ascii = @Value  : Debug *pValueA\a      ;用一个ASCII型指针指向变量Value
Debug ""


;上述用法,相当于联合结构
Structure __TestInfo
   StructureUnion
      ValueL.l
      ValueW.w
      ValueB.b
      ValueA.a
   EndStructureUnion
EndStructure

ValueTest.__TestInfo 
ValueTest\ValueL = $55667788
Debug Hex(ValueTest\ValueL)
Debug Hex(ValueTest\ValueW)
Debug ValueTest\ValueB
Debug ValueTest\ValueA
Debug ""


;没有对比就没有伤害,指针用起来比较灵活.
;此外,还有可以移动指针
*pValueA.Ascii = @Value :  Debug Hex(*pValueA\a)
*pValueA + 1            :  Debug Hex(*pValueA\a) 
*pValueA + 1            :  Debug Hex(*pValueA\a) 
*pValueA + 1            :  Debug Hex(*pValueA\a) 

;指针可以移动赋值
Debug ""
*pValueL\l = $12345678
Debug Hex(*pValueL\l)
Debug Hex(*pValueW\w)
Debug Hex(*pValueB\b)
Debug Hex(*pValueA\a)
Debug ""

*pValueA\a = $FF
Debug Hex(*pValueL\l)
Debug Hex(*pValueW\w)
Debug Hex(*pValueB\b)
Debug Hex(*pValueA\a)
Debug ""


; 【3.用来指向字符串】
Text$ = "PureBasic"
;注意: PUB先前的版本支持 *pString.String = @Text$, 当前版本不支持.
;字符串变量本身就是一个指针,所以,我们需要用*pPoint存放这个指针,然后用*pString.String是指向它

*pPoint = @Text$  
*pString.String = @*pPoint: Debug *pString\s
*pString\s = "迷路仟"     : Debug Text$  ;对指针赋值,字符串变量也会跟着改变
Debug ""

; 【4.用来指向结构体】
Point.Points            
Point\x = $1234
Point\y = $5678

;强制将Points结构变成LONG型
*pPointL.long = Point      ;如果指向的变量是结构体,可以加@,也可以不加@
; *pPointL.long = @Point     ;两者是等效的
Debug Hex(*pPointL\l)


*pPointL\l = $11223344
Debug Hex(Point\x)
Debug Hex(Point\y)
Debug ""

;如:采用不同的方法,代码的复杂度就不一样
;正常的用法
GetCursorPos_(Mouse2.Point)                     ;获取光标位置
Debug WindowFromPoint_(Mouse2\y<<32|Mouse2\x)   ;判断光标位置所在的控件句柄

;巧妙的用法,把Point结构,当于一个QUAD类型,就可以省于第二个函数的数值转换过程
GetCursorPos_(@Mouse1.q)            ;获取光标位置
Debug WindowFromPoint_(Mouse1)      ;判断光标位置所在的控件句柄
Debug ""  
      
        
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 98
; FirstLine = 53
; Folding = +
; EnableXP