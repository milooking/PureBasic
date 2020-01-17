;***********************************
;迷路仟整理 2019.01.25
;LZMA压缩文件
;***********************************


UseLZMAPacker()  ; 使用LZMA压缩解压器

;创建LZMA压缩文件
;注意: 1.PackEntryName()对中文字符不友好.2.无视后辍名
PackerID = CreatePack(#PB_Any, "LZMA测试.7z", #PB_PackerPlugin_Lzma|#PB_Packer_Gzip, 9)  
If PackerID
    AddPackFile(PackerID, ".\LZMAPacker_LZMA压缩文件.pb", "LZMATestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\LZMAPacker_LZMA压缩文件.pb", "LZMATestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\LZMAPacker_LZMA压缩文件.pb", "LZMATestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\LZMAPacker_LZMA压缩文件.pb", "LZMATestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\LZMAPacker_LZMA压缩文件.pb", "LZMATestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf
 
;打开LZMA压缩文件
PackerID = OpenPack(#PB_Any, "LZMA测试.7z", #PB_PackerPlugin_Lzma) 
If PackerID 
   If ExaminePack(PackerID)
      While NextPackEntry(PackerID)
        FileName$ = PackEntryName(PackerID) 
        Debug "文件: " + FileName$ + ", 大小: " + PackEntrySize(PackerID)
        ;UncompressPackFile(PackerID, "源代码.pb", FileName$)
      Wend
   EndIf
   ClosePack(PackerID)
EndIf

 
 
 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; FirstLine = 8
; EnableXP