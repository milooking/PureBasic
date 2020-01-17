;***********************************
;迷路仟整理 2019.01.22
;VariablesType_数据类型
;***********************************

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
; 为了区分字符串类型的变量,PureBasic为字符串变量提供了一个方便的定义:$:, 如String$,表示字符串,相当于String.s

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

ValueF.f = 1.2345789
ValueD.D = 1.2345789
Debug ""
Debug "单精浮点: " + StrF(ValueF)
Debug "双精浮点: " + StrD(ValueD)
Debug "两个数相等吗? " + Bool(ValueF = ValueD)  ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueF = 1.2345789) ;0表示不相等,1表示相等
Debug "两个数相等吗? " + Bool(ValueD = 1.2345789)  ;0表示不相等,1表示相等

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


Debug ""
Debug "============= 指针类型 ============="
;注意:
;指针,内存,用*开头,PureBasic5.3以后不需要.l这个类型.
;基本数据类型的指针结构
;  .b  -> .Byte
;  .a  -> .Ascii
;  .c  -> .Character
;  .w  -> .Word
;  .u  -> .Unicode
;  .l  -> .Long
;  .i  -> .Integer
;  .f  -> .Float
;  .q  -> .Quad
;  .d  -> .Double
; 如: 
TestByte.b = 123  
*pByte.byte = @TestByte  :  Debug "*pByte\b = " + *pByte\b

TestWord.w = 12345
*pWord.word = @TestWord  :  Debug "*pWord\w = " + *pWord\w

TestLong.l = 12345789
*pLong.long = @TestLong  :  Debug "*pLong\l = " + *pLong\l

TestFloat.f = 1.2345789
*pFloat.float = @TestFloat : Debug "*pFloat\f = " + *pFloat\f

TestString.s = "12345789"
*pStringAddr = @TestString ;需要二次取址
*pString.string = @*pStringAddr : Debug "*pString\s = " + *pString\s

TestString$ = "987654321"
*pStringAddr = @TestString$  ;需要二次取址
*pString.string = @*pStringAddr : Debug "*pString\s = " + *pString\s

;-
;***********************************
;*********     强制声明    *********
;***********************************
;-[EnableExplicit] 强制声明
EnableExplicit  
; 表示强制变量需要声明才有效,因为PureBasic中,
; 支持变量默认为Integer的情况,即不声明为.i



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; FirstLine = 112
; EnableThread
; EnableXP