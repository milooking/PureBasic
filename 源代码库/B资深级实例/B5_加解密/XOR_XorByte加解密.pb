;***********************************
;迷路仟整理 2018.11.14
;XorByte加解密
;***********************************

 Procedure XorByte(*pMemText, TextLen.l, Key.b) 
   !MOV ecx, dword [p.v_TextLen]
   !MOV esi, dword [p.p_pMemText]
   !MOV edi, dword [p.p_pMemText]
   !CLD 
   !_Cipher: 
   !lodsb 
   !XOR al, byte [p.v_Key]
   !stosb 
   !LOOP _Cipher 
EndProcedure 


Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"
Key$ = "Miloo King"  
XorByte(@Cipher$, StringByteLength(Cipher$), $7F)
Debug "加密: " + Cipher$
XorByte(@Cipher$, StringByteLength(Cipher$), $7F)
Debug "解密: " + Cipher$




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableAsm
; EnableXP
; EnableUnicode