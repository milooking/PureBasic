;***********************************
;迷路仟整理 2019.01.23
;Crypt_AES加解密1
;***********************************



String$ = "欢迎使用 [迷路PureBasic实例库工具]! "
Debug "明文为: " + String$

;AES-CBC模式
StringBytes  = StringByteLength(String$) 
*pMemEncoder = AllocateMemory(StringBytes)   
*pMemDecoder = AllocateMemory(StringBytes) 

If AESEncoder(@String$, *pMemEncoder, StringBytes, ?_Bin_AESKey, 128, ?_Bin_InitVector)
   Debug ""
   Debug " ====== AES-CBC模式 ======"
   Debug "加密后: " + PeekS(*pMemEncoder) 
   AESDecoder(*pMemEncoder, *pMemDecoder, StringBytes, ?_Bin_AESKey, 128, ?_Bin_InitVector)
   Debug "解密后: " + PeekS(*pMemDecoder)
EndIf

If AESEncoder(@String$, *pMemEncoder, StringBytes, ?_Bin_AESKey, 128, 0, #PB_Cipher_ECB)
   Debug ""
   Debug " ====== AES-ECB模式 ======"
   Debug "加密后: " + PeekS(*pMemEncoder) 
   AESDecoder(*pMemEncoder, *pMemDecoder, StringBytes, ?_Bin_AESKey, 128, 0, #PB_Cipher_ECB)
   Debug "解密后: " + PeekS(*pMemDecoder)
EndIf



DataSection
_Bin_AESKey:
   Data.b $06, $a9, $21, $40, $36, $b8, $a1, $5b, $51, $2e, $03, $d5, $34, $12, $00, $06
  
_Bin_InitVector:
   Data.b $3d, $af, $ba, $42, $9d, $9e, $b4, $30, $b4, $22, $da, $80, $2c, $9f, $ac, $41
EndDataSection











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP