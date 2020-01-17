;【注】自己用TBManager编译成内置模块(LIB),
;      或将[McsNikeName]复制到[..\PureBasic-5.62-x86\PureLibraries\UserLibraries\]目录中
;      把"zlib.lib"复制到[..\PureBasic\PureLibraries\Windows\Libraries\]目录中
;***********************************************************
;************      迷路内置库模块:取名模块      ************
;************ 作者: 迷路仟/Miloo [QQ:714095563] ************
;************        2019版 [2018.11.15]       *************
;***********************************************************


#ENG_Linked$ = "|,丨,の,、,ヽ,ヾ"
#CHI_Linked$ = "的,の,、,ヽ,ヾ,ヽ,DE,De,DI,Di,de,di,的,の,、,ヽ,ヾ,ヽ,"
#ALL_Symbol$ = "、,ヽ,ヾ,ヽ,‖,々,～,…,★,◆,■,☆,◇,□,→,←,↑,↓,↓,丿,丨,灬,巛,ゝ,〆,丨,、,ヽ,ヾ,ヽ,丨,、,ヽ,ヾ,ヽ,"


Enumeration 
   #Nike_Creature       ;生物类
   #Nike_Sundries       ;杂物类
   #Nike_ENGNames       ;外国风
   #Nike_CHINames       ;中国风
   #Nike_RoleName       ;角色类
   #Nike_Emotions       ;情感类
   #Nike_LifeSale       ;单字动植物比例
   #Nike_ForeSale       ;英文名比例
   
   #Nike_MainPrefix     
   #Nike_LifePrefix     ;动植物前辍
   #Nike_LifeSuffix     ;动植物后辍
   #Nike_PersPrefix     ;拟人化前辍
   #Nike_PersSuffix     ;拟人化后辍
   #Nike_MoodPrefix     ;情绪化前辍
   #Nike_MoodSuffix     ;情绪化后辍   
   
   #Nike_LifeMixt       ;单字动植物
   #Nike_BiolMixt       ;多字动植物
   #Nike_SundMixt       ;杂物类主语
   #Nike_ForeMixt       ;英文姓名
   #Nike_TranMixt       ;英译姓名
   #Nike_CHISMixt       ;中文姓名
   #Nike_RoleMixt       ;角色类主语
   #Nike_EmotMixt       ;情感类主语
   #Nike_NonmMixt       ;非主流主语
   #Nike_Count
EndEnumeration


Structure __NikeGroupInfo
   StructureUnion
      IdxAddr.l
      Limit0.l
   EndStructureUnion
   StructureUnion
      Count.l
      Limit1.l
   EndStructureUnion
EndStructure

Structure __NikeNameInfo
   *pMemIndex
   *pMemNames
   *pMemSurname
   RandomValue.q
   ENGLinked$
   CHILinked$
   ALLSymbol$
   DimNikeIndex.__NikeGroupInfo[#Nike_Count]
EndStructure


;- Import
ImportC "zlib.lib"
   uncompress(*MemExtData, *ExtSize, *MemVirData, *VirSize)   
EndImport


Procedure.l NikeName_CRC32(*pMemData, DataSize)  ;CRC32校验
   !MOV Esi, dword [p.p_pMemData] ;esi = ptr to *pMemData
   !MOV Edi, dword [p.v_DataSize] ;edi = length of *pMemData 
   !MOV Ecx, -1                 ;ecx = -1 
   !MOV Edx, Ecx                ;edx = -1 
   !_crc321:                    ;"nextbyte" next byte from *pMemData
   !XOR Eax, Eax                ;eax = 0 
   !XOR Ebx, Ebx                ;ebx = 0 
   !DB 0xAC                     ;"lodsb" instruction to get next byte
   !XOR al, cl                  ;xor al with cl 
   !MOV cl, ch                  ;cl = ch 
   !MOV ch, dl                  ;ch = dl 
   !MOV dl, dh                  ;dl = dh
   !MOV dh, 8                   ;dh = 8 
   !_crc322:                    ;"nextbit" next bit in the byte
   !SHR bx, 1                   ;shift bits in bx right by 1 
   !RCR ax, 1                   ;(rotate through carry) bits in ax by 1 
   !JNC near _crc323            ;jump to "nocarry" if carry flag not set 
   !XOR ax, 0x08320             ;xor ax with 33568 
   !XOR bx, 0x0EDB8             ;xor bx with 60856
   !_crc323:                    ;"nocarry" if carry flag wasn't set
   !DEC dh                      ;dh = dh - 1 
   !JNZ near _crc322            ;if dh isnt zero, jump to "nextbit" 
   !XOR Ecx, Eax                ;xor ecx with eax 
   !XOR Edx, Ebx                ;xor edx with ebx 
   !DEC Edi                     ;finished with that byte, decrement counter 
   !JNZ near _crc321            ;if edi counter isnt at 0, jump to "nextbyte" 
   !NOT Edx                     ;invert edx bits - 1s complement 
   !NOT Ecx                     ;invert ecx bits - 1s complement 
   !MOV Eax, Edx                ;mov edx into eax 
   !ROL Eax, 16                 ;rotate bits in eax left by 16 places 
   !MOV ax, cx                  ;mov cx into ax 
  ProcedureReturn
EndProcedure

Procedure$ NikeName_CreateCreature(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      If (\RandomValue >> 3) % 1024 <= \DimNikeIndex[#Nike_LifeSale]\Limit1
         MixtValue = (\RandomValue >> 4) % \DimNikeIndex[#Nike_LifeMixt]\Count
         MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeMixt]\IdxAddr+MixtValue*4)
         MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)  
         Select (\RandomValue >> 5) % 35
            Case 01 To 19 
               NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_LifePrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifePrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+MixtName$
            Case 20 To 29 
               NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_LifeSuffix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeSuffix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = MixtName$+NestName$
         EndSelect 
      Else 
         MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_BiolMixt]\Count
         MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_BiolMixt]\IdxAddr+MixtValue*4)
         MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii) 
      EndIf 
        
      Select (\RandomValue >> 2) % 35
         Case 01 To 19 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 20 To 29 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
      EndSelect
      
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 14 To 14 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 15 To 17 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      EndIf 
   EndWith
   ProcedureReturn  MixtName$
EndProcedure
   
Procedure$ NikeName_CreateSundries(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_SundMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_SundMixt]\IdxAddr+MixtValue*4)
      MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
      Select (\RandomValue >> 2) % 35
         Case 00
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            MixtName$ = NestName$
         Case 01 To 19 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 20 To 29 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
      EndSelect
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 14 To 14 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 15 To 16 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      EndIf 
   EndWith
   ProcedureReturn  MixtName$
EndProcedure
   
Procedure$ NikeName_CreateENGNames(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      If (\RandomValue >> 8) % 1024 <= \DimNikeIndex[#Nike_ForeSale]\Limit1
         MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_ForeMixt]\Count
         MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_ForeMixt]\IdxAddr+MixtValue*4)
         MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)  
         Select (\RandomValue >> 2) % 31
            Case 01 To 07 
               NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = NestName$+Linked$+MixtName$
            Case 08 To 10 
               NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodSuffix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodSuffix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$+Linked$+NestName$
            Case 11  
               LifeValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_LifeMixt]\Count
               LifeAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeMixt]\IdxAddr+LifeValue * 4)
               LifeName$ = PeekS(\pMemNames+LifeAddr, -1, #PB_Ascii)  
               Select (\RandomValue >> 4) % 35
                  Case 01 To 19 
                     NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifePrefix]\Count
                     NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifePrefix]\IdxAddr+NestValue*4)
                     NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                     LifeName$ = NestName$+LifeName$
                  Case 20 To 29 
                     NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifeSuffix]\Count
                     NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeSuffix]\IdxAddr+NestValue*4)
                     NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                     LifeName$ = LifeName$+NestName$
               EndSelect 
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$+Linked$+LifeName$
            Case 12 To 16   
               BiolValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_BiolMixt]\Count
               BiolAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_BiolMixt]\IdxAddr+BiolValue * 4)
               BiolName$ = PeekS(\pMemNames+BiolAddr, -1, #PB_Ascii)  
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$+Linked$+BiolName$
            Case 17 To 21   
               SundValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_SundMixt]\Count
               SundAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_SundMixt]\IdxAddr+SundValue * 4)
               SundName$ = PeekS(\pMemNames+SundAddr, -1, #PB_Ascii)  
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$+Linked$+SundName$
            Default
               If (\RandomValue >> 3) % 8 = 0
                  Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
                  MixtName$ = MixtName$ + Linked$ + Str(1990 + (\RandomValue >> 5) % 27)
               ElseIf (\RandomValue >> 3) % 8 = 1
                  MixtName$ = MixtName$ + Str(1990 + (\RandomValue >> 5) % 27)
               EndIf 
         EndSelect 
      Else 
         MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_TranMixt]\Count
         MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_TranMixt]\IdxAddr+MixtValue*4)
         MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)  
         Select (\RandomValue >> 2) % 31
            Case 01 To 07 
               NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
               MixtName$ = NestName$+Linked$+MixtName$
            Case 08 To 10 
               NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodSuffix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodSuffix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
               MixtName$ = MixtName$+Linked$+NestName$
            Case 11  
               LifeValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_LifeMixt]\Count
               LifeAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeMixt]\IdxAddr+LifeValue * 4)
               LifeName$ = PeekS(\pMemNames+LifeAddr, -1, #PB_Ascii)  
               Select (\RandomValue >> 4) % 35
                  Case 01 To 19 
                     NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifePrefix]\Count
                     NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifePrefix]\IdxAddr+NestValue*4)
                     NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                     LifeName$ = NestName$+LifeName$
                  Case 20 To 29 
                     NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifeSuffix]\Count
                     NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeSuffix]\IdxAddr+NestValue*4)
                     NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                     LifeName$ = LifeName$+NestName$
               EndSelect 
               Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
               MixtName$ = MixtName$+Linked$+LifeName$
            Case 12 To 16   
               BiolValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_BiolMixt]\Count
               BiolAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_BiolMixt]\IdxAddr+BiolValue * 4)
               BiolName$ = PeekS(\pMemNames+BiolAddr, -1, #PB_Ascii)  
               Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
               MixtName$ = MixtName$+Linked$+BiolName$
               
            Case 17 To 21   
               SundValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_SundMixt]\Count
               SundAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_SundMixt]\IdxAddr+SundValue * 4)
               SundName$ = PeekS(\pMemNames+SundAddr, -1, #PB_Ascii)  
               Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
               MixtName$ = MixtName$+Linked$+SundName$
               
            Default
               If (\RandomValue >> 3) % 8 = 0
                  Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
                  MixtName$ = MixtName$ + Linked$ + Str(1990 + (\RandomValue >> 5) % 27)
               ElseIf (\RandomValue >> 3) % 8 = 1
                  MixtName$ = MixtName$ + Str(1990 + (\RandomValue >> 5) % 27)
               EndIf 
         EndSelect 
         
      EndIf 
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 14 To 14 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 15 To 16 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      ElseIf (\RandomValue >> 6) % 8 = 0 
         SymbolPrefix$   = StringField(\ENGLinked$, (\RandomValue >> 5) % CountENGLinked+1, ",")
         NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_MainPrefix]\Count
         NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
         NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
         MixtName$ = NestName$+SymbolPrefix$+MixtName$
      EndIf
   EndWith 
   ProcedureReturn  MixtName$
EndProcedure
     
Procedure$ NikeName_CreateCHINames(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_CHISMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_CHISMixt]\IdxAddr+MixtValue*4)
      MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
      Select (\RandomValue >> 2) % 31
         Case 01 To 07 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 08 To 10 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
            
         Case 11  
            LifeValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_LifeMixt]\Count
            LifeAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeMixt]\IdxAddr+LifeValue * 4)
            LifeName$ = PeekS(\pMemNames+LifeAddr, -1, #PB_Ascii)  
            Select (\RandomValue >> 4) % 35
               Case 01 To 19 
                  NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifePrefix]\Count
                  NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifePrefix]\IdxAddr+NestValue*4)
                  NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                  LifeName$ = NestName$+LifeName$
               Case 20 To 29 
                  NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifeSuffix]\Count
                  NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeSuffix]\IdxAddr+NestValue*4)
                  NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                  LifeName$ = LifeName$+NestName$
            EndSelect 
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+LifeName$
         Case 12 To 16   
            BiolValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_BiolMixt]\Count
            BiolAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_BiolMixt]\IdxAddr+BiolValue * 4)
            BiolName$ = PeekS(\pMemNames+BiolAddr, -1, #PB_Ascii)  
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+BiolName$
            
         Case 17 To 21   
            SundValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_SundMixt]\Count
            SundAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_SundMixt]\IdxAddr+SundValue * 4)
            SundName$ = PeekS(\pMemNames+SundAddr, -1, #PB_Ascii)  
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+SundName$
         Default
            If (\RandomValue >> 3) % 8 = 0
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$ + Linked$ + Str(1990 + (\RandomValue >> 5) % 27)
            ElseIf (\RandomValue >> 3) % 8 = 1
               MixtName$ = MixtName$ + Str(1990 + (\RandomValue >> 5) % 27)
            EndIf 
      EndSelect
      
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 14 To 14 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 15 To 16 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      ElseIf (\RandomValue >> 6) % 8 = 0 
         SymbolPrefix$   = StringField(\ENGLinked$, (\RandomValue >> 5) % CountENGLinked+1, ",")
         NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_MainPrefix]\Count
         NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
         NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
         MixtName$ = NestName$+SymbolPrefix$+MixtName$
      EndIf
   EndWith 
   ProcedureReturn  MixtName$
EndProcedure
     
Procedure$ NikeName_CreateRoleName(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_CHISMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_CHISMixt]\IdxAddr+MixtValue*4)
      MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
      Select (\RandomValue >> 2) % 31
         Case 01 To 07
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 08 To 10 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
            
            
         Case 11  
            LifeValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_LifeMixt]\Count
            LifeAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeMixt]\IdxAddr+LifeValue * 4)
            LifeName$ = PeekS(\pMemNames+LifeAddr, -1, #PB_Ascii)  
            Select (\RandomValue >> 4) % 35
               Case 01 To 19 
                  NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifePrefix]\Count
                  NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifePrefix]\IdxAddr+NestValue*4)
                  NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                  LifeName$ = NestName$+LifeName$
               Case 20 To 29 
                  NestValue = (\RandomValue >> 5) % \DimNikeIndex[#Nike_LifeSuffix]\Count
                  NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_LifeSuffix]\IdxAddr+NestValue*4)
                  NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
                  LifeName$ = LifeName$+NestName$
            EndSelect 
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+LifeName$
         Case 12 To 16   
            BiolValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_BiolMixt]\Count
            BiolAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_BiolMixt]\IdxAddr+BiolValue * 4)
            BiolName$ = PeekS(\pMemNames+BiolAddr, -1, #PB_Ascii)  
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+BiolName$
            
         Case 17 To 21   
            SundValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_SundMixt]\Count
            SundAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_SundMixt]\IdxAddr+SundValue * 4)
            SundName$ = PeekS(\pMemNames+SundAddr, -1, #PB_Ascii)  
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+SundName$
            
         Default
            If (\RandomValue >> 3) % 8 = 0
               Linked$   = StringField(\ENGLinked$, (\RandomValue >> 4) % CountENGLinked+1, ",")
               MixtName$ = MixtName$ + Linked$ + Str(1990 + (\RandomValue >> 5) % 27)
            ElseIf (\RandomValue >> 3) % 8 = 1
               MixtName$ = MixtName$ + Str(1990 + (\RandomValue >> 5) % 27)
            EndIf 
      EndSelect
      
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 14 To 14 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 15 To 16 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      ElseIf (\RandomValue >> 6) % 8 = 0 
         SymbolPrefix$   = StringField(\ENGLinked$, (\RandomValue >> 5) % CountENGLinked+1, ",")
         NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_MainPrefix]\Count
         NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
         NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
         MixtName$ = NestName$+SymbolPrefix$+MixtName$
      EndIf
   EndWith
   ProcedureReturn  MixtName$
EndProcedure
         
Procedure$ NikeName_CreateEmotions(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_EmotMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_EmotMixt]\IdxAddr+MixtValue*4)
      MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
      Select (\RandomValue >> 2) % 31
         Case 00
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            MixtName$ = NestName$
         Case 01 To 09 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 10 To 19 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_MoodSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MoodSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
      EndSelect
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 23
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 10 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 11 To 11 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 12 To 18 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      ElseIf (\RandomValue >> 6) % 8 = 0 
         SymbolPrefix$   = StringField(\ENGLinked$, (\RandomValue >> 5) % CountENGLinked+1, ",")
         NestValue = (\RandomValue >> 6) % \DimNikeIndex[#Nike_MainPrefix]\Count
         NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
         NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
         MixtName$ = NestName$+SymbolPrefix$+MixtName$
      EndIf
   EndWith
   ProcedureReturn  MixtName$
EndProcedure
   
Procedure$ NikeName_CreateNonMains(*pNikeName.__NikeNameInfo)
   With *pNikeName
      CountENGLinked =  CountString(\ENGLinked$, ",")
      CountCHILinked =  CountString(\CHILinked$, ",")
      CountALLSymbol =  CountString(\ALLSymbol$, ",")
      ;=======================
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_NonmMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_NonmMixt]\IdxAddr+MixtValue*4)
      MixtName$ = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
      Select (\RandomValue >> 2) % 31
         Case 01 To 05 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersPrefix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersPrefix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = NestName$+Linked$+MixtName$
         Case 06 To 09 
            NestValue = (\RandomValue >> 3) % \DimNikeIndex[#Nike_PersSuffix]\Count
            NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_PersSuffix]\IdxAddr+NestValue*4)
            NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
            Linked$   = StringField(\CHILinked$, (\RandomValue >> 4) % CountCHILinked+1, ",")
            MixtName$ = MixtName$+Linked$+NestName$
      EndSelect
      If CountALLSymbol 
         SymbolPrefix$   = StringField(\ALLSymbol$, (\RandomValue >> 5) % CountALLSymbol+1, ",")
         Select (\RandomValue >> 6) % 30
            Case 00 To 00 : MixtName$ = SymbolPrefix$ + MixtName$
            Case 01 To 01 : MixtName$ = MixtName$ + SymbolPrefix$
            Case 02 To 02 : MixtName$ = SymbolPrefix$ + ReplaceString(MixtName$, Linked$, SymbolPrefix$)
            Case 03 To 03 : MixtName$ = ReplaceString(MixtName$, Linked$, SymbolPrefix$) + SymbolPrefix$
            Case 04 To 11 : MixtName$ = SymbolPrefix$ + MixtName$ + SymbolPrefix$
            Case 12 To 13 : MixtName$ = SymbolPrefix$ + MixtName$ + StringField(\ALLSymbol$, (\RandomValue >> 7) % CountALLSymbol+1, ",")
            Case 14 To 19 
               NestValue = (\RandomValue >> 7) % \DimNikeIndex[#Nike_MainPrefix]\Count
               NestAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+NestValue*4)
               NestName$ = PeekS(\pMemNames+NestAddr, -1, #PB_Ascii)
               MixtName$ = NestName$+SymbolPrefix$+MixtName$
         EndSelect
      EndIf 
   EndWith
   ProcedureReturn  MixtName$
EndProcedure
   

;-

Procedure$ NikeName_CreateNikeName(*pNikeName.__NikeNameInfo)
   If *pNikeName = 0 : ProcedureReturn : EndIf 
   With *pNikeName
      If \RandomValue = 0 : \RandomValue = Random(99999999999, 1000000000) : EndIf
      CopyMemory_(@\DimNikeIndex[0], *pNikeName\pMemIndex, #Nike_Count*8)
      \ENGLinked$ = #ENG_Linked$
      \CHILinked$ = #CHI_Linked$
      \RandomValue = NikeName_CRC32(@RandomValue, 8)  & $FFFFFFFF + \RandomValue
   
      Select \RandomValue % 1024
         Case \DimNikeIndex[#Nike_Creature]\Limit0 To \DimNikeIndex[#Nike_Creature]\Limit1  ;生物类
            NikeName$ = NikeName_CreateCreature(*pNikeName)
         Case \DimNikeIndex[#Nike_Sundries]\Limit0 To \DimNikeIndex[#Nike_Sundries]\Limit1  ;杂物类
            NikeName$ = NikeName_CreateSundries(*pNikeName)
         Case \DimNikeIndex[#Nike_ENGNames]\Limit0 To \DimNikeIndex[#Nike_ENGNames]\Limit1  ;外国风
            NikeName$ = NikeName_CreateENGNames(*pNikeName)
         Case \DimNikeIndex[#Nike_CHINames]\Limit0 To \DimNikeIndex[#Nike_CHINames]\Limit1  ;中国风
            NikeName$ = NikeName_CreateCHINames(*pNikeName)
         Case \DimNikeIndex[#Nike_RoleName]\Limit0 To \DimNikeIndex[#Nike_RoleName]\Limit1  ;角色类
            NikeName$ = NikeName_CreateRoleName(*pNikeName)         
         Case \DimNikeIndex[#Nike_Emotions]\Limit0 To \DimNikeIndex[#Nike_Emotions]\Limit1  ;情感类
            NikeName$ = NikeName_CreateEmotions(*pNikeName)
         Default  ;非主流
            NikeName$ = NikeName_CreateNonMains(*pNikeName)
      EndSelect
   EndWith
   ProcedureReturn  NikeName$
EndProcedure

Procedure$ NikeName_CreateAccounts(*pNikeName.__NikeNameInfo)

   If *pNikeName = 0 : ProcedureReturn : EndIf 

   Type = Random(2)
   With *pNikeName
      If \RandomValue = 0 : \RandomValue = Random(99999999999, 1000000000) : EndIf
      CopyMemory_(@\DimNikeIndex[0], \pMemIndex, #Nike_Count*8)
      Select Type 
         Case 1
            \RandomValue = NikeName_CRC32(@\RandomValue, 8) & $0FFFFFFF + (\RandomValue& $00FFFFFF) * 5 
         Case 2
            \RandomValue = NikeName_CRC32(@\RandomValue, 8) & $0FFFFFFF + (\RandomValue& $00FFFFFF) * 3
         Default
            \RandomValue = NikeName_CRC32(@\RandomValue, 8) & $0FFFFFFF + (\RandomValue& $00FFFFFF) 
      EndSelect 
   
      \ENGLinked$ = "_,,_,_,,"
;       \ENGLinked$ = "_,__,_,__,,___,___,_,__,___,,____,_,__,,__,,____,__,,____,"
      CountENGLinked =  CountString(\ENGLinked$, ",")
      Linked$   = StringField(\ENGLinked$, (\RandomValue) % CountENGLinked+1, ",")
   
      MixtValue = (\RandomValue >> 1) % \DimNikeIndex[#Nike_ForeMixt]\Count
      MixtAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_ForeMixt]\IdxAddr+MixtValue * 4)
      Account$  = PeekS(\pMemNames+MixtAddr, -1, #PB_Ascii)
            
      Select (\RandomValue >> 2) % 8
         Case 00 :
            PrefixValue = (Random(\RandomValue)) % \DimNikeIndex[#Nike_MainPrefix]\Count
            PrefixAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+PrefixValue * 4 )
            PrefixName$ = PeekS(\pMemNames+PrefixAddr, -1, #PB_Ascii)
            Account$ = PrefixName$+Linked$+LCase(Account$)
         Case 01 :
            PrefixValue = (Random(\RandomValue)) % \DimNikeIndex[#Nike_MainPrefix]\Count
            PrefixAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+PrefixValue * 4 )
            PrefixName$ = PeekS(\pMemNames+PrefixAddr, -1, #PB_Ascii)
            Account$ = Account$+Linked$+LCase(PrefixName$)
            
         Case 02,03 :
            PrefixValue = (Random(\RandomValue)) % \DimNikeIndex[#Nike_MainPrefix]\Count
            PrefixAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+PrefixValue * 4 )
            PrefixName$ = PeekS(\pMemNames+PrefixAddr, -1, #PB_Ascii)
            Account$ = PrefixName$+Linked$+LCase(Account$)
         Case 04, 05:
            PrefixValue = (Random(\RandomValue)) % \DimNikeIndex[#Nike_MainPrefix]\Count
            PrefixAddr  = PeekL(\pMemIndex+\DimNikeIndex[#Nike_MainPrefix]\IdxAddr+PrefixValue * 4 )
            PrefixName$ = PeekS(\pMemNames+PrefixAddr, -1, #PB_Ascii)
            Account$ = Account$+Linked$+LCase(PrefixName$)
         Case 06 :
            Account$ = Account$+Linked$+ Str(Random(2016, 1900))        
         Case 07 :
            Account$ = Account$+Linked$+ Str(Random(999))
      EndSelect
   EndWith
   ProcedureReturn  Account$
EndProcedure

Procedure$ NikeName_CreateSurnames(*pNikeName.__NikeNameInfo)
   
   If *pNikeName = 0 : ProcedureReturn : EndIf 
   Province = 00
   PhoneCRC = Random(999999)
   With *pNikeName
      ScaleSize  = PeekL(\pMemSurname)      : Pos = 4           ;比例值大小
      *pScale    = \pMemSurname + Pos       : Pos + ScaleSize   ;
      ScaleIndex = PeekB(*pScale+(PhoneCRC) % 999) & $FF
      CountSurn  = PeekW(\pMemSurname+Pos)  : Pos + 2
      SurnSize   = PeekW(\pMemSurname+Pos)  : Pos + 2
      
   
      If ((PhoneCRC>>1) % 9)< 2
         ScaleIndex = (PhoneCRC>>2) % 499 + 256 
         *pSurname  = \pMemSurname + Pos + ScaleIndex * 2
         Surname$   = PeekS(*pSurname, 2, #PB_Ascii) 
         Select Surname$
            Case "一" : Surname$ = "欧阳"
            Case "二" : Surname$ = "尉迟"
            Case "三" : Surname$ = "东方"
            Case "四" : Surname$ = "鲜于"
            Case "五" : Surname$ = "申屠"
            Case "六" : Surname$ = "司徒"
            Case "七" : Surname$ = "上官"
            Case "八" : Surname$ = "诸葛"
            Case "九" : Surname$ = "令狐"
         EndSelect 
      Else 
         *pSurname  = \pMemSurname + Pos + ScaleIndex * 2
         Surname$   = PeekS(*pSurname, 2, #PB_Ascii) 
      EndIf 
   
      Pos + SurnSize * CountSurn
      CountMale  = PeekL(\pMemSurname+Pos)  : Pos + 4
      *pMaleName = \pMemSurname+Pos         : Pos + CountMale * 4
      CountGirl  = PeekL(\pMemSurname+Pos)  : Pos + 4
      *pGirlName = \pMemSurname+Pos         : Pos + CountGirl * 4
   
      If Random(1)
         If (PhoneCRC>>3) % 9 = 0
            *pMaleName = *pMaleName + ((PhoneCRC>>4) % (CountMale*2))*2
            RandomName$ = Surname$ + PeekS(*pMaleName, 2, #PB_Ascii)
         Else 
            *pMaleName = *pMaleName + ((PhoneCRC>>5) % CountMale)*4
            RandomName$ = Surname$ + PeekS(*pMaleName, 4, #PB_Ascii)
         EndIf  
      Else
         If (PhoneCRC>>3) % 9 = 0
            *pGirlName = *pGirlName + ((PhoneCRC>>4) % (CountGirl*2))*2
            RandomName$ = Surname$ + PeekS(*pGirlName, 2, #PB_Ascii)
         Else 
            *pGirlName = *pGirlName + ((PhoneCRC>>5) % CountGirl)*4
            RandomName$ = Surname$ + PeekS(*pGirlName, 4, #PB_Ascii)
         EndIf  
      EndIf 
   EndWith
   ProcedureReturn RandomName$
EndProcedure


;- 
;- ===============

ProcedureDLL mcsCatchNikeName()  ;使用批量创建
   *pNikeName.__NikeNameInfo = AllocateMemory(SizeOf(__NikeNameInfo))
   ExtSize = PeekL(?_BIN_NikeIndex+00)
   VirSize = PeekL(?_BIN_NikeIndex+04)
   *pNikeName\pMemIndex = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemIndex, @ExtSize, ?_BIN_NikeIndex+08, VirSize) 
   
   ExtSize = PeekL(?_BIN_NikeNames+00)
   VirSize = PeekL(?_BIN_NikeNames+04)
   *pNikeName\pMemNames = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemNames, @ExtSize, ?_BIN_NikeNames+08, VirSize) 
   
   ExtSize = PeekL(?_BIN_Surname+00)
   VirSize = PeekL(?_BIN_Surname+04)
   *pNikeName\pMemSurname = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemSurname, @ExtSize, ?_BIN_Surname+08, VirSize) 
   ProcedureReturn *pNikeName
EndProcedure

ProcedureDLL$ mcsCreateNikeNameFast_(NikeNameID)   ;快速创建昵称
   ProcedureReturn NikeName_CreateNikeName(NikeNameID)
EndProcedure

ProcedureDLL$ mcsCreateAccountsFast_(NikeNameID)   ;快速创建帐号
   ProcedureReturn NikeName_CreateAccounts(NikeNameID)
EndProcedure

ProcedureDLL$ mcsCreateSurnamesFast_(NikeNameID)   ;快速创建姓名
   ProcedureReturn NikeName_CreateSurnames(NikeNameID)
EndProcedure

ProcedureDLL mcsFreeNikeName_(NikeNameID) ;注销批量创建
   *pNikeName.__NikeNameInfo = NikeNameID
   If *pNikeName = 0 : ProcedureReturn : EndIf 
   FreeMemory(*pNikeName\pMemIndex)
   FreeMemory(*pNikeName\pMemNames)
   FreeMemory(*pNikeName\pMemSurname)
   FreeMemory(*pNikeName)
EndProcedure

ProcedureDLL$ mcsCreateNikeName_()  ;创建昵称
   *pNikeName.__NikeNameInfo = AllocateMemory(SizeOf(__NikeNameInfo))
   ExtSize = PeekL(?_BIN_NikeIndex+00)
   VirSize = PeekL(?_BIN_NikeIndex+04)
   *pNikeName\pMemIndex = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemIndex, @ExtSize, ?_BIN_NikeIndex+08, VirSize) 
   
   ExtSize = PeekL(?_BIN_NikeNames+00)
   VirSize = PeekL(?_BIN_NikeNames+04)
   *pNikeName\pMemNames = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemNames, @ExtSize, ?_BIN_NikeNames+08, VirSize) 
   
   NikeName$ = NikeName_CreateNikeName(*pNikeName)
   FreeMemory(*pNikeName\pMemIndex)
   FreeMemory(*pNikeName\pMemNames)
   FreeMemory(*pNikeName)
   ProcedureReturn NikeName$
EndProcedure

ProcedureDLL$ mcsCreateAccounts_()  ;创建帐号
   *pNikeName.__NikeNameInfo = AllocateMemory(SizeOf(__NikeNameInfo))
   ExtSize = PeekL(?_BIN_NikeIndex+00)
   VirSize = PeekL(?_BIN_NikeIndex+04)
   *pNikeName\pMemIndex = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemIndex, @ExtSize, ?_BIN_NikeIndex+08, VirSize) 
   
   ExtSize = PeekL(?_BIN_NikeNames+00)
   VirSize = PeekL(?_BIN_NikeNames+04)
   *pNikeName\pMemNames = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemNames, @ExtSize, ?_BIN_NikeNames+08, VirSize) 
   
   NikeName$ = NikeName_CreateAccounts(*pNikeName)
   FreeMemory(*pNikeName\pMemIndex)
   FreeMemory(*pNikeName\pMemNames)
   FreeMemory(*pNikeName)
   ProcedureReturn NikeName$
EndProcedure

ProcedureDLL$ mcsCreateSurnames_()  ;创建姓名
   *pNikeName.__NikeNameInfo = AllocateMemory(SizeOf(__NikeNameInfo))
   ExtSize = PeekL(?_BIN_Surname+00)
   VirSize = PeekL(?_BIN_Surname+04)
   *pNikeName\pMemSurname = AllocateMemory(ExtSize)
   uncompress(*pNikeName\pMemSurname, @ExtSize, ?_BIN_Surname+08, VirSize) 
   
   NikeName$ = NikeName_CreateSurnames(*pNikeName)
   FreeMemory(*pNikeName\pMemSurname)
   FreeMemory(*pNikeName)
   ProcedureReturn NikeName$
EndProcedure


;- 
;- DataSection
DataSection
   _BIN_NikeIndex:   
      IncludeBinary ".\NikeIndex.pack"   
   _BIN_NikeNames:  
      IncludeBinary ".\NikeNames.pack"      
   _BIN_Surname:   
      IncludeBinary ".\Surname.pack"
EndDataSection




; IDE Options = PureBasic 5.62 (Windows - x86)
; ExecutableFormat = Shared dll
; CursorPosition = 9
; Folding = IAg--
; Markers = 111
; EnableAsm
; EnableXP
; Executable = 新建文件夹\NikeName.dll
; Constant = #MCS_Test=5