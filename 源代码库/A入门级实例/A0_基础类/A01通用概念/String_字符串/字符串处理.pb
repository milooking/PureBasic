;***********************************
;迷路仟整理 2019.01.29
;字符串处理
;***********************************

;【字符长度】
Debug "====== 【字符长度】 ======"
Debug Len("My name is Miloo!")   ; = 17
Debug Len("叫我迷路仟!")         ; = 6

;【字节长度】
Debug "====== 【字节长度】 ======"
;StringByteLength()获取的是字符中写入到内存或磁盘中所需要占用的字节数.
;根所储存的字符串的编码格式相关
Text$ = "叫我迷路仟!"
Debug StringByteLength(Text$, #PB_Ascii)     ;= 11
Debug StringByteLength(Text$, #PB_Unicode)   ;= 12
Debug StringByteLength(Text$, #PB_UTF8)      ;= 16

;【取小写】
Debug "====== 【取小写】 ======"
Debug LCase("This is Art")    ; "this is art"

;【取大写】
Debug "====== 【取大写】 ======"
Debug UCase("This is Art")    ; "THIS IS ART"

;【左对齐】
Debug "====== 【左对齐】 ======"
Debug LSet("123", 8)          ; "123     "
Debug LSet("123", 8, "-")     ; "123-----"
Debug LSet("12345678", 4)     ; "1234"

;【右对齐】
Debug "====== 【右对齐】 ======"
Debug RSet("123", 8)          ; "     123"
Debug RSet("123", 8, "0")     ; "00000123"
Debug RSet("12345678", 4)     ; "1234"

;【左截取】
Debug "====== 【左截取】 ======"
Debug Left("This is Art!", 4)    ;"This"

;【右截取】
Debug "====== 【右截取】 ======"
Debug Right("This is Art!", 4)   ;"Art!"

;【任意截取】
Debug "====== 【任意截取】 ======"
Debug Mid("Hello", 2)         ; "ello"
Debug Mid("Hello", 2, 1)      ; "e"


;【左修剪】
Debug "====== 【左修剪】 ======"
Debug LTrim("   This is Art  ")     ; "This is Art  "
Debug LTrim("!!Hello Word", "!")    ; "Hello World"

;【右修剪】
Debug "====== 【右修剪】 ======"
Debug RTrim("  This is Art   ")     ; "  This is Art"
Debug RTrim("Hello Word!!", "!")    ; "Hello World"

;【两向修剪】
Debug "====== 【两向修剪】 ======"
Debug Trim("   Hello     ")         ; "Hello"
Debug Trim("!!Hello!!", "!")        ; "Hello"

;【占位字符】:产生空格
Debug "====== 【占位字符】 ======"
Debug "-" + Space(5) + "-"          ; "-     -"

;【求格式化的字符串】
Debug "====== 【求格式化的字符串】 ======"
Debug UnescapeString(~"Test=\"Hello\".")                                      ;Test="Hello".
Debug UnescapeString("&lt;item&gt;Hello&lt;/item&gt;", #PB_String_EscapeXML)  ;<item>Hello</item>

;【获取格式化字符串】
Debug "====== 【获取格式化字符串】 ======"
Debug EscapeString("Test="+Chr(34)+"Hello"+Chr(34)+".")           ; "Test=\"Hello\"."
Debug EscapeString("<item>Hello</item>", #PB_String_EscapeXML)    ; "&lt;item&gt;Hello&lt;/item&gt;"


;【统计字符】
Debug "====== 【统计字符】 ======"
Debug CountString("How many 'ow' contains Bow ?", "ow")  ; 3,返回"ow"的数量

;【查找字符】
Debug "====== 【查找字符】 ======"
Debug FindString("PureBasic", "Bas")      ; 5 返回"Bas"的位置

;【删除字符】
Debug "====== 【删除字符】 ======"
Debug RemoveString("This is Art", "is")                                 ;"Th  Art"
Debug RemoveString("This is Art", "is", #PB_String_CaseSensitive, 1, 1) ;"Th is Art"

;【插入字符】
Debug "====== 【插入字符】 ======"
Debug InsertString("Hello !", "World", 7)  ; "Hello World!"
Debug InsertString("Hello !", "World", 1)  ; "WorldHello !"

;【替换字符】
Debug "====== 【替换字符】 ======"
Debug ReplaceString("This is Art", " is", " was")                             ; "This was Art"
Debug ReplaceString("Hello again, hello again", "HELLO", "oh no...", 1, 10)   ; "Hello again, oh no... again"

Text$ = "Bundy, Barbie, Buddy"
ReplaceString(Text$, "B", "Z",  #PB_String_InPlace, 1) 
Debug Text$

;【翻转字符】
Debug "====== 【翻转字符】 ======"
Debug ReverseString("Hello")     ;"olleH"




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 114
; FirstLine = 85
; EnableThread
; EnableXP