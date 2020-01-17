;***********************************
;迷路仟整理 2019.01.23
;Crypt_Base64加解密2
;***********************************

String$ = "欢迎使用 [迷路PureBasic实例库工具]! "
StringBytes  = StringByteLength(String$) + 1
Debug "明文为: " + String$

;默认的文本编码是: #PB_Unicode
*pMemEncoder = AllocateMemory(1024) 
Result = Base64EncoderBuffer(@String$, StringBytes, *pMemEncoder, 1024)
Debug "加密后: " + PeekS(*pMemEncoder, -1, #PB_Ascii)
Debug "加密后大小: " + Result

*pMemDecoder = AllocateMemory(1024) 
Result = Base64DecoderBuffer(*pMemEncoder, Result, *pMemDecoder, 1024)
Debug "解密后: " + PeekS(*pMemDecoder)











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP