;***********************************
;迷路仟整理 2018.11.14
;CRC32-x.224校验
;***********************************
;CRC32-x.224校验
Procedure.l Cipher_Adler32(*pMemData, DataSize, InitSeed)   
  !MOV Edx, dword [p.v_InitSeed]
  !MOVZX Ecx, dx
  !SHR Edx, 16
  !MOV Esi, dword [p.p_pMemData]
  !MOV Eax, dword [p.v_DataSize]
  !ADD Eax, Esi
  !XOR Ebx, Ebx
  !_alder321:
  !MOV bl, [Esi]
  !ADD Ecx, Ebx
  !CMP Ecx, 65521
  !JB near _alder322
  !SUB Ecx, 65521
  !_alder322:
  !ADD Edx, Ecx
  !CMP Edx, 65521
  !JB near _alder323
  !SUB Edx, 65521
  !_alder323:
  !INC Esi
  !CMP Esi, Eax
  !JNZ near _alder321
  !SHL Edx, 16
  !ADD Ecx, Edx
  !MOV Eax, Ecx
  ProcedureReturn
EndProcedure

Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"

Cipher = Cipher_Adler32(@Cipher$, StringByteLength(Cipher$), 0)
Debug "Adler32: = 0x" + Hex(Cipher, #PB_Long)





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; Folding = +
; EnableXP
; EnableUnicode