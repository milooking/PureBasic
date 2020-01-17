;***********************************
;迷路仟整理 2015.09.17
;静态链接口接入
;***********************************


;- 接口部分
ImportC "zlib.lib"
   compress2 (*MemCompress, *VirSize, *MemUnCompress, ExtSize, Level)
   uncompress(*MemUnCompress, *ExtSize, *MemCompress, VirSize)   
EndImport

Import "lzma_32.lib"
   LzmaCompress  (*MemPack,   *VirSize, *MemUnPack, ExtSize,  *MemHeader, HeaderSize, PackLevel, iDictSize, Lc, Lp, Pb, Fb, iNumThreads) 
   LzmaUncompress(*MemUnPack, *ExtSize, *MemPack,   *VirSize, *MemHeader, HeaderSize)
EndImport









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP