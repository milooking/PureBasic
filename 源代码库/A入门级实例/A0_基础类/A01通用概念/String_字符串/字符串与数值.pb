;***********************************
;迷路仟整理 2019.01.29
;字符串与数值
;***********************************


;【字符串转整型数值】 $开头表示16进制, %开头表示二进制
Debug "====== 【字符串转整型数值】 ======"
Debug Val("1024102410241024") ; '1024102410241024'.
Debug Val("$10FFFFFFFF")      ; '73014444031'.
Debug Val("%1000")            ; '8'.

;【字符串转浮点数值】
Debug "====== 【字符串转浮点数值】 ======"
Debug ValF("10.24")           ;10.24
Debug ValF("1.2345e+3")       ;1234.5

Debug ValD("10.000024")       ;10.000024
Debug ValD("1.2345e-2")       ;0.012345


;【整型数值转字符串】
Debug "====== 【整型数值转字符串】 ======"
Value.q = 100000000000000001  
Debug Str(Value)              ;100000000000000001
Debug StrU(Value, #PB_Long)   ;1569325057

Byte.b = 255
Debug Str(Byte)               ; -1
Debug StrU(Byte, #PB_Byte)    ; 255

;【数值转二进制字符串】
Debug "====== 【数值转二进制字符串】 ======"
Debug "%"+Bin(32)             ;"%100000"

;【数值转16进制字符串】
Debug "====== 【数值转16进制字符串】 ======"
Debug "0x"+Hex(-1)            ; 0xFFFFFFFFFFFFFFFF
Debug "0x"+Hex(-1, #PB_Byte)  ; 0xFF
Debug "0x"+Hex(-1, #PB_Word)  ; 0xFFFF
Debug "0x"+Hex(-1, #PB_Long)  ; 0xFFFFFFFF
Debug "0x"+Hex(-1, #PB_Quad)  ; 0xFFFFFFFFFFFFFFFF

;【浮点数值转字符串】
Debug "====== 【浮点数值转字符串】 ======"
ValueF.f = 10.54
Debug "Result: " + StrF(ValueF)    
Debug "Result: " + ValueF          
Debug "Result: " + StrF(ValueF,2)  
Debug "Result: " + StrF(ValueF,0)

ValueD.d = 10.54
Debug "Result: " + StrD(ValueD)     
Debug "Result: " + ValueD         
Debug "Result: " + StrD(ValueD, 2) 
Debug "Result: " + StrD(ValueD, 0)

;【浮点数值会计文本】
Debug "====== 【浮点数值会计文本】 ======"
Debug FormatNumber(125400.25) ;125,000.25


;【字符转数值】
Debug "====== 【字符转数值】 ======"
Debug '!'            ; '33'
Debug Asc("!")       ; '33'
Debug Asc("€")      ; '8364' = 0x20AC 

Unicode$="€€ "
Debug Asc(Unicode$)  ;'8364'
ShowMemoryViewer(@Unicode$,8)

;【数值转字符】
Debug "====== 【数值转字符】 ======"
Debug Chr($41)       ; A
Debug Chr($4E2D)     ; 中
Debug Chr($56FD)     ; 国





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableThread
; EnableXP