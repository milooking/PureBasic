;***********************************
;迷路仟整理 2019.01.25
;BriefLZ压缩文件
;***********************************


UseBriefLZPacker()  ; 使用BriefLZ压缩解压器

;创建BriefLZ压缩文件
;注意: 1.PackEntryName()对中文字符不友好.2.无视后辍名
PackerID = CreatePack(#PB_Any, "BriefLZ测试.blz", #PB_PackerPlugin_BriefLZ|#PB_Packer_Gzip, 9)  
If PackerID
    AddPackFile(PackerID, ".\BriefLZPacker_BriefLZ压缩文件.pb", "BriefLZTestCode1.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\BriefLZPacker_BriefLZ压缩文件.pb", "BriefLZTestCode2.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\BriefLZPacker_BriefLZ压缩文件.pb", "BriefLZTestCode3.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\BriefLZPacker_BriefLZ压缩文件.pb", "BriefLZTestCode4.pb")    ; 添加压缩文件
    AddPackFile(PackerID, ".\BriefLZPacker_BriefLZ压缩文件.pb", "BriefLZTestCode5.pb")    ; 添加压缩文件
    ClosePack(PackerID)   
EndIf
 
;打开BriefLZ压缩文件
PackerID = OpenPack(#PB_Any, "BriefLZ测试.blz", #PB_PackerPlugin_BriefLZ) 
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
; CursorPosition = 27
; FirstLine = 8
; EnableXP