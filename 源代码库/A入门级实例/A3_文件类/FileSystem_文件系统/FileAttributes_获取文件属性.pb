;***********************************
;迷路仟整理 2019.01.27
;FileAttributes_获取文件属性
;***********************************


Attributes = GetFileAttributes(".\测试.txt")
If Attributes & #PB_FileSystem_Hidden    
   Debug "这是一个隐藏文件 !"
   
   If Attributes & #PB_FileSystem_Hidden     : Attribute$ + "H" : Else : Attribute$+"-" : EndIf 
   If Attributes & #PB_FileSystem_Archive    : Attribute$ + "A" : Else : Attribute$+"-" : EndIf 
   If Attributes & #PB_FileSystem_Compressed : Attribute$ + "C" : Else : Attribute$+"-" : EndIf 
   If Attributes & #PB_FileSystem_Normal     : Attribute$ + "N" : Else : Attribute$+"-" : EndIf 
   If Attributes & #PB_FileSystem_ReadOnly   : Attribute$ + "R" : Else : Attribute$+"-" : EndIf 
   If Attributes & #PB_FileSystem_System     : Attribute$ + "S" : Else : Attribute$+"-" : EndIf 
   Debug Attribute$ 
EndIf
  




  
  
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; EnableXP