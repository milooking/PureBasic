;***********************************
;迷路仟整理 2019.02.22
;压缩库接口
;***********************************
;- 接口部分
ImportC "zlib.lib"
   compress2 (*MemPack, *pPackSize, *MemData, DataSize, Level)
   uncompress(*MemData, *pDataSize, *MemPack, PackSize)  
EndImport

Import "lzma_32.lib"
   LzmaCompress  (*MemPack, *pPackSize, *MemData, DataSize,  *MemHeader, HeaderSize, PackLevel, iDictSize, Lc, Lp, Pb, Fb, iNumThreads) 
   LzmaUncompress(*MemData, *pDataSize, *MemPack, *pPackSize, *MemHeader, HeaderSize)
EndImport



















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP