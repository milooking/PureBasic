;***********************************
;迷路仟整理 2019.01.23
;Crypt_AES加解密2
;***********************************



String$ = "欢迎使用 [迷路PureBasic实例库工具]! "


Debug "明文为: " + String$

;AES-CBC模式
StringBytes  = StringByteLength(String$) 
*pMemEncoder = AllocateMemory(StringBytes)   
*pMemDecoder = AllocateMemory(StringBytes) 

CipherID = StartAESCipher(#PB_Any, ?_Bin_AESKey, 128, ?_Bin_InitVector, #PB_Cipher_Encode|#PB_Cipher_CBC)
If CipherID
   Debug ""
   Debug " ====== AES-分段加密 ======"
   AddCipherBuffer(CipherID, @String$, *pMemEncoder, 16)
   AddCipherBuffer(CipherID, @String$+16, *pMemEncoder+16, StringBytes-16)
   FinishCipher(CipherID)
   Debug "加密后: " + PeekS(*pMemEncoder) 
   
   AESDecoder(*pMemEncoder, *pMemDecoder, StringBytes, ?_Bin_AESKey, 128, ?_Bin_InitVector)
   Debug "解密后: " + PeekS(*pMemDecoder)
EndIf 


If AESEncoder(@String$, *pMemEncoder, StringBytes, ?_Bin_AESKey, 128, ?_Bin_InitVector)
   Debug ""
   Debug " ====== AES-对比 ======"
   Debug "加密后: " + PeekS(*pMemEncoder) 
   AESDecoder(*pMemEncoder, *pMemDecoder, StringBytes, ?_Bin_AESKey, 128, ?_Bin_InitVector)
   Debug "解密后: " + PeekS(*pMemDecoder)
EndIf



DataSection
_Bin_AESKey:
   Data.b $06, $a9, $21, $40, $36, $b8, $a1, $5b, $51, $2e, $03, $d5, $34, $12, $00, $06
  
_Bin_InitVector:
   Data.b $3d, $af, $ba, $42, $9d, $9e, $b4, $30, $b4, $22, $da, $80, $2c, $9f, $ac, $41
EndDataSection











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP