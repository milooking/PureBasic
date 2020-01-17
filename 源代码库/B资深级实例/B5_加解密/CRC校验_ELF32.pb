;***********************************
;迷路仟整理 2018.11.14
;CRC32-校验UNIX专用
;***********************************

;CRC32-校验UNIX专用
Procedure.l Cipher_ELF32(*pMemData, DataSize)  
  !XOR Ebx, Ebx                ; ebx = result holder (H)
  !MOV Edx, dword [p.v_DataSize] ; edx = Length
  !MOV Ecx, dword [p.p_pMemData] ; ecx = Ptr to string
  !XOR Esi, Esi                ; esi = temp holder
  !_elf321:
  !XOR Eax, Eax
  !SHL Ebx, 4
  !MOV al, [Ecx]
  !ADD Ebx, Eax
  !INC Ecx
  !MOV Eax, Ebx
  !AND Eax, 0xF0000000
  !CMP Eax, 0
  !JE near _elf322
  !MOV Esi, Eax
  !SHR Esi, 24
  !XOR Ebx, Esi
  !_elf322:
  !NOT Eax
  !AND Ebx,Eax
  !DEC Edx
  !CMP Edx, 0
  !JNE near _elf321
  !MOV Eax, Ebx
  ProcedureReturn
EndProcedure

Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"

Cipher = Cipher_ELF32(@Cipher$, StringByteLength(Cipher$))
Debug "ELF32: = 0x" + Hex(Cipher, #PB_Long)





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; Folding = +
; EnableXP
; EnableUnicode