;***********************************
;迷路仟整理 2019.01.23
;Crypt_Base64加解密1
;***********************************


String$ = "欢迎使用 [迷路PureBasic实例库工具]! "
StringBytes  = StringByteLength(String$, #PB_UTF8) + 1
Debug "明文为: " + String$

;==================
*pMemString = UTF8(String$)
Encoder$ = Base64Encoder(*pMemString, StringBytes)
Debug "加密后: " + Encoder$

*pMemDecoder = AllocateMemory(1024)
Base64Decoder(Encoder$, *pMemDecoder, 1024)
Debug "解密后: " + PeekS(*pMemDecoder, -1, #PB_UTF8)

;==================
Debug ""
*pMemString = AllocateMemory(StringBytes)
PokeS(*pMemString, String$, -1, #PB_UTF8)
Encoder$ = Base64Encoder(*pMemString, StringBytes)
Debug "加密后: " + Encoder$

*pMemDecoder = AllocateMemory(1024)
Base64Decoder(Encoder$, *pMemDecoder, 1024)
Debug "解密后: " + PeekS(*pMemDecoder, -1, #PB_UTF8)



;==================
;默认的文本编码是: #PB_Unicode
Debug ""
Encoder$ = Base64Encoder(@String$, StringBytes)
Debug "加密后: " + Encoder$

*pMemDecoder = AllocateMemory(1024)
Base64Decoder(Encoder$, *pMemDecoder, 1024)
Debug "解密后: " + PeekS(*pMemDecoder)











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP