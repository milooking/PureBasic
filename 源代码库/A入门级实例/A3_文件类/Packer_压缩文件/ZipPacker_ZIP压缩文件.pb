;***********************************
;迷路仟整理 2019.01.25
;ZIP压缩文件
;***********************************


UseZipPacker()  ; 使用ZIP压缩解压器

;创建ZIP压缩文件
;注意: 1.PackEntryName()对中文字符不友好.2.无视后辍名
PackerID = CreatePack(#PB_Any, "ZIP测试.zip", #PB_PackerPlugin_Zip, 9)  
If PackerID
    AddPackFile(PackerID, ".\ZipPacker_ZIP压缩文件.pb", "ZipTestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\ZipPacker_ZIP压缩文件.pb", "ZipTestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\ZipPacker_ZIP压缩文件.pb", "ZipTestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\ZipPacker_ZIP压缩文件.pb", "ZipTestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\ZipPacker_ZIP压缩文件.pb", "ZipTestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf
 
;打开ZIP压缩文件
PackerID = OpenPack(#PB_Any, "ZIP测试.zip", #PB_PackerPlugin_Zip) 
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
; CursorPosition = 30
; FirstLine = 8
; EnableXP