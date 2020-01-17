;***********************************
;迷路仟整理 2019.01.22
;数据结构,常量,变量等等
;***********************************


;- [Variables]数据类型
; 字符值型: Ascii,Character,Unicode
; 整型类型: Byte,Word,Long,Quad
; 浮点类型: Float,Double
; 字符串型: String,String{}

; 名称      定义 字节   数据范围
; Byte      .b    1     -128 至 +127 
; Ascii     .a    1     0 至 +255 
; Character .c    1     0 至 +255(5.4x或以下版本)
; Character .c    2     0 至 +65535 (Unicode模式)
; Word      .w    2     -32768 至 +32767 
; Unicode   .u    2     0 至 +65535 
; Long      .l    4     -2147483648 至 +2147483647 
; Integer   .i    4     -2147483648 至 +2147483647 (32位编译器)
; Integer   .i    8     -9223372036854775808 至 +9223372036854775807 (64位编译器)
; Float     .f    4     无穷小 至 无穷大
; Quad      .q    8     -9223372036854775808 To +9223372036854775807 
; Double    .d    8     无穷小 至 无穷大

; 名称         定义        字节
; String       .s          Length + 1 unlimited 
; Fixed String .s{Length}  Length

; 严格意义上,浮点数据的有效范围为: 
; 单精浮点(Float) : +- 1.175494e-38 till +- 3.402823e+38 
; 双精浮点(Double): +- 2.2250738585072013e-308 till +- 1.7976931348623157e+308 


; PureBasic的早期版,数值没有符号之分.如今加了入Ascii, Character, Unicode这三个异类
; 如果需要使用无符号数值是,PureBasic提供了一个解决方案:

ValueB.b = 255

Debug "============= 数据类型 ============="
Debug "有符号数值: " + Str(ValueB)
Debug "无符号数值: " + Str(ValueB & $FF)

ValueW.w = $FFEE

Debug "有符号数值: " + Str(ValueW)
Debug "无符号数值: " + Str(ValueW & $FFFF)

ValueL.l = $FFEEDDCC

Debug "有符号数值: " + Str(ValueL)
Debug "无符号数值: " + Str(ValueL & $FFFFFFFF)



Debug ""
Debug "============= 数值表达 ============="
;数值表达1: 整型数值和字符值数值,无进制符表示十进制, $进制符表示16进制, %进制符表示二进制

Debug "十进制:  100 = " + 100
Debug "16进制: $100 = " + $100  ;相当于0x100 或 100h
Debug "二进制: %100 = " + %100

;数值表达2: 浮点数值可以用科学记数法来表示
Debug "常规记数法: 0.000123 = " + 0.000123
Debug "科学记数法: 1.23E-4  = " + 1.23E-4

;注: 浮点数值是近似数值,不是确定数值,所以用于比较时,最好不要用来比较是否相于,容易产生各种诡异的现象

ValueF.f = 0.0123
ValueD.D = 0.0123
Debug ""
Debug "单精浮点: " + StrF(ValueF)
Debug "双精浮点: " + StrD(ValueD)
Debug "两个数相等吗? " + Bool(ValueF = ValueD)  ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueF = 1.23E-2) ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueD = 0.0123)  ;0表示不相等,1表示相等

*MemData = AllocateMemory(100)
PokeF(*MemData, ValueD)
TempF.f = PeekF(*MemData)
TempD.d = PeekF(*MemData)
Debug ""
Debug "单精浮点: " + StrF(TempF)
Debug "双精浮点: " + StrD(TempD)
Debug "两个数相等吗? " + Bool(ValueF = TempF)   ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueD = TempD)   ;0表示不相等,1表示相等


PokeD(*MemData, ValueD)
TempF.f = PeekD(*MemData)
TempD.d = PeekD(*MemData)
Debug ""
Debug "单精浮点: " + StrF(TempF)
Debug "双精浮点: " + StrD(TempD)
Debug "两个数相等吗? " + Bool(ValueF = TempF)   ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueD = TempD)   ;0表示不相等,1表示相等


;-
;- [Define]定义
; Define.<type> [<variable> [= <expression>], <variable> [= <expression>], ...]
Debug ""
Debug "============= [Define] ============="
Define.b a, b = 10, c = b*2, d 

Define MyChar.c 
Define MyLong.l 
Define MyWord.w 

Debug "结构大小: " + SizeOf(MyChar)   ; 显示 2
Debug "结构大小: " + SizeOf(MyLong)   ; 显示 4
Debug "结构大小: " + SizeOf(MyWord)   ; 显示 2





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 99
; FirstLine = 82
; EnableXP