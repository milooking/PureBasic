;***********************************
;迷路仟整理 2018.11.14
;CRC32校验高速算法
;***********************************

;CRC32校验高速算法
Procedure.l Cipher_FNV32(*pMemData, DataSize, InitSeed) 
  !MOV Esi, dword [p.p_pMemData] 
  !MOV Ecx, dword [p.v_DataSize] 
  !MOV Eax, dword [p.v_InitSeed] 
  !MOV Edi, 0x01000193            
  !XOR Ebx, Ebx              
  !_fnv321:
  !MUL Edi                    
  !MOV bl, [Esi]                  
  !XOR Eax, Ebx                 
  !INC Esi                   
  !DEC Ecx                   
  !JNZ near _fnv321     
  ProcedureReturn
EndProcedure

Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"

Cipher = Cipher_FNV32(@Cipher$, StringByteLength(Cipher$), 0)
Debug "FNV32: = 0x" + Hex(Cipher, #PB_Long)





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; Folding = +
; EnableXP
; EnableUnicode