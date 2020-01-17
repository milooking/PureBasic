;***********************************
;迷路仟整理 2018.11.14
;XOR加解密
;***********************************

 
Procedure XorAsm(*pMemText, TextLen.l, *pMemKeyMin, *pMemKeyMax)  
  !MOV Ebx, dword [p.p_pMemKeyMin]   
  !MOV Ecx, dword [p.v_TextLen]     
  !MOV Esi, dword [p.p_pMemText]    
  !MOV Edi, dword [p.p_pMemText] 
  !CLD     
  !l_S1:         
    !LODSb            
    !MOV ah, [Ebx]    
    !INC Ebx     
    !XOR al, ah      
    !stosb         
    !CMP Ebx, dword [p.p_pMemKeyMax] 
    !JNA l_W1      
    !MOV Ebx, dword [p.p_pMemKeyMin] 
    !l_W1:               
    !DEC Ecx 
  !JNZ l_S1    
EndProcedure  
 
Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"
Key$ = "Miloo King"  
XorAsm(@Cipher$, StringByteLength(Cipher$), @Key$, @Key$+StringByteLength(Key$)-1)
Debug "加密: " + Cipher$
XorAsm(@Cipher$, StringByteLength(Cipher$), @Key$, @Key$+StringByteLength(Key$)-1)
Debug "解密: " + Cipher$




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; Folding = -
; EnableAsm
; EnableXP
; EnableUnicode