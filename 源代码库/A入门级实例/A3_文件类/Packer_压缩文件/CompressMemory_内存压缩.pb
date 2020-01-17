;***********************************
;迷路仟整理 2019.01.25
;ZIP压缩文件
;***********************************

UseBriefLZPacker()
UseLZMAPacker()
UseZipPacker()

;随机创建一些数字
MemSize = $1000
*MemData = AllocateMemory(MemSize)
For k = 0 To MemSize-1
   PokeB(*MemData+k, Random('9', '0')) ;相当于随机0-9个数字, '9'等价于Asc("9")
Next 

;对内存块进行压缩
PackSize = MemSize
*MemPack = AllocateMemory(MemSize)
PackSize = CompressMemory(*MemData, MemSize, *MemPack, PackSize , #PB_PackerPlugin_Zip , 9)
ShowMemoryViewer(*MemPack, PackSize)
 
;对内存块进行解压
*MemUnPack = AllocateMemory(MemSize)
UnPackSize = UncompressMemory(*MemPack, PackSize, *MemUnPack, MemSize, #PB_PackerPlugin_Zip)
ShowMemoryViewer(*MemPack, UnPackSize)
 
 
Debug "MemSize    = " + MemSize
Debug "PackSize   = " + PackSize
Debug "UnPackSize = " + UnPackSize
 
 
 
 
 
 
 
 
 
 
 
 
 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; FirstLine = 2
; EnableXP