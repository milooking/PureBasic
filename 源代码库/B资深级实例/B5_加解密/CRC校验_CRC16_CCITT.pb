;***********************************
;迷路仟整理 2018.11.14
;CRC32-CCITT校验
;***********************************
;CRC16-CCITT校验
Procedure.w Cipher_CRC16_CCITT(*MemData, len) 
  !mov eax, 0xffff
  !mov ecx, [p.v_len]
  CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
    !mov rdx, [p.p_MemData]
    !push rbx
    !crc16ccitt0:
    !mov bl, [rdx]
    !inc rdx
  CompilerElse
    !mov edx, [p.p_MemData]
    !push ebx
    !crc16ccitt0:
    !mov bl, [edx]
    !inc edx
  CompilerEndIf
  !mov bh, 8
  !crc16ccitt1:
  !shl bl, 1
  !rcl ax, 1
  !jnc crc16ccitt2
  !xor ax, 0x1021
  !crc16ccitt2:
  !dec bh
  !jnz crc16ccitt1
  !dec ecx
  !jnz crc16ccitt0
  !mov bh, 16
  !crc16ccitt3:
  !shl bl, 1
  !rcl ax, 1
  !jnc crc16ccitt4
  !xor ax, 0x1021
  !crc16ccitt4:
  !dec bh
  !jnz crc16ccitt3
  CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
    !pop rbx
  CompilerElse
    !pop ebx
  CompilerEndIf
  ProcedureReturn
EndProcedure

Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"

Cipher = Cipher_CRC16_CCITT(@Cipher$, StringByteLength(Cipher$))
Debug "CRC16-CCITT: = 0x" + Hex(Cipher)


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 49
; Folding = +
; EnableXP
; EnableUnicode