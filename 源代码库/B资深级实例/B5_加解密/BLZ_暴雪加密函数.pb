;***********************************
;迷路仟整理 2018.11.14
; 暴雪加密函数
;***********************************

; 初始化
Procedure BLZ_InitKeyTable()
   Static *pMemKeyTable
   *pMemKeyTable = AllocateMemory($500*4)
   SeedVal = $00100001
   For x = 0 To 255
      For y = 0 To 4
         SeedVal = (SeedVal * 125 + 3) % $2AAAAB;
         HiValue = (SeedVal & $FFFF) << 16;
         SeedVal = (SeedVal * 125 + 3) % $2AAAAB;
         LoValue = (SeedVal & $FFFF);
         *pValue.long = *pMemKeyTable + (y*$100+x)*4
         *pValue\l = (HiValue|LoValue);
      Next       
   Next 
   ProcedureReturn *pMemKeyTable
EndProcedure

; 暴雪加密函数
Procedure BLZ_EncryptData(*MemData, MemSize, KeyValue, Offset=0)
   Static *pMemKeyTable
   If *pMemKeyTable = 0 
      *pMemKeyTable = BLZ_InitKeyTable()
   EndIf 
   SeedVal = $EEEEEEEE;
   For k = 0 To MemSize - 4 Step 4
      *pValue.long = *pMemKeyTable + (KeyValue & $FF)*4
      SeedVal + *pValue\l
      Value   = PeekL(*MemData+k)
      Result  = Value!(KeyValue + SeedVal)
      KeyValue= (~KeyValue<<$15+$11111111)|(KeyValue>>$0B)
      SeedVal = Value + SeedVal + SeedVal<<5 + 3
      PokeL(*MemData+k, Result)      
   Next 
EndProcedure


Cipher$ = "欢迎使用[迷路PureBasic实例库工具]"

BLZ_EncryptData(@Cipher$, StringByteLength(Cipher$), 123456)
ShowMemoryViewer(@Cipher$, StringByteLength(Cipher$))
Debug Cipher$



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 46
; Folding = 9
; EnableXP
; EnableUnicode