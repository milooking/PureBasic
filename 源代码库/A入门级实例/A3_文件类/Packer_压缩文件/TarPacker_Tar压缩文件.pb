;***********************************
;迷路仟整理 2019.01.25
;Tar压缩文件
;***********************************


UseTARPacker()  ; 使用Tar压缩解压器

;创建Tar压缩文件
;注意: 1.PackEntryName()对中文字符不友好.2.无视后辍名
PackerID = CreatePack(#PB_Any, "Tar测试.tar", #PB_PackerPlugin_Tar, 9)  
If PackerID
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "TarTestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "TarTestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "TarTestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "TarTestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "TarTestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf
 

PackerID = CreatePack(#PB_Any, "Tar测试.gzip", #PB_PackerPlugin_Tar|#PB_Packer_Gzip, 9)  
If PackerID
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "GzipTestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "GzipTestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "GzipTestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "GzipTestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "GzipTestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf


PackerID = CreatePack(#PB_Any, "Tar测试.bz2", #PB_PackerPlugin_Tar|#PB_Packer_Bzip2, 9)  
If PackerID
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "Bzip2TestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "Bzip2TestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "Bzip2TestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "Bzip2TestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\TarPacker_Tar压缩文件.pb", "Bzip2TestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf

 
 
;打开Tar压缩文件
PackerID = OpenPack(#PB_Any, "Tar测试.tar", #PB_PackerPlugin_Tar) 
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
 
Debug ""
 ;打开Tar压缩文件
PackerID = OpenPack(#PB_Any, "Tar测试.gzip", #PB_PackerPlugin_Tar|#PB_Packer_Gzip) 
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

 
 Debug ""
;打开Tar压缩文件
PackerID = OpenPack(#PB_Any, "Tar测试.bz2", #PB_PackerPlugin_Tar|#PB_Packer_Bzip2) 
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
; CursorPosition = 73
; FirstLine = 58
; EnableXP