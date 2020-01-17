;***********************************
;迷路仟整理 2019.01.23
;Crypt_Random产生随机数
;***********************************

;加密体系下的随机数
If OpenCryptRandom()
   For k = 1 To  10
      Result = CryptRandom(1000)
      Debug "随机数: " + Result
   Next 
   CloseCryptRandom()
EndIf 

Debug ""
;系统体系下的随机系,
RandomSeed(100)  ;只要随机种子一样,产生的随机数都一样,所以,随机数其实是伪随机
For k = 1 To  10
   Result = Random(1000)
   Debug "随机数: " + Result
Next 


;随机数据块,主要用于产生随机加密KEY
If OpenCryptRandom()
   *MemKey = AllocateMemory(16)
   CryptRandomData(*MemKey, 16)
   CloseCryptRandom()
   Text$ = "随机Key:"
   For i = 0 To 15
      Text$ + " 0x" + RSet(Hex(PeekB(*MemKey+i), #PB_Byte), 2, "0")
   Next
   Debug "" 
   Debug Text$ 
EndIf 


















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP