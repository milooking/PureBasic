;***********************************
;迷路仟整理 2019.01.28
;AllocateMemory_申请内存
;***********************************
;【注】为了规范代码,内存习惯以*Mem开头,全局变量以*_Mem开头,指向内存的指针以*pMem开头


*MemData = AllocateMemory(5000)
If *MemData
   Debug "开始申请一个长度为5000字节的内存块"
   Debug *MemData
   PokeS(*MemData, "这段文本将被写入到内存中!")
   FreeMemory(*MemData)    ;释放内存
Else
   Debug "申请内存失败!"
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableXP