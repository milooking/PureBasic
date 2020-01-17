;***********************************
;迷路仟整理 2019.02.22
;ZLIB压缩库实例
;***********************************
;- 接口部分
ImportC "zlib.lib"
   compress2 (*MemPack, *pPackSize, *MemData, DataSize, Level)
   uncompress(*MemData, *pDataSize, *MemPack, PackSize)   
EndImport

; 创建完整路径
Procedure Zlib_CreateFullPath(FileName$)
   FileName$ = ReplaceString(FileName$, "/", "\")
   For x = 1 To CountString(FileName$, "\")
      Floder$ = StringField(FileName$, x, "\") + "\"
      SavePath$ + Floder$
      If FileSize(SavePath$) <> -2 And Mid(Floder$,2,1) <> ":"
         CreateDirectory(SavePath$)
         Result = #True
      EndIf 
   Next 
   ProcedureReturn Result
EndProcedure

;压缩数据
Procedure Zlib_PackData(*MemData, DataSize, PackLevel=5)    
   PackSize = DataSize * 1.2
   *MemPack = AllocateMemory(PackSize)
   compress2 (*MemPack, @PackSize, *MemData, DataSize, PackLevel)
   *MemPack = ReAllocateMemory(*MemPack, PackSize)
   ProcedureReturn *MemPack
EndProcedure

;压缩数据
Procedure Zlib_PackMemory(*MemPack, *pPackSize, *MemData, DataSize, PackLevel=5)
   Result = compress2 (*MemPack, *pPackSize, *MemData, DataSize, PackLevel)
   ProcedureReturn Result 
EndProcedure

;压缩数据并保存为文件(DataSize+PackSize+PackData) 
Procedure Zlib_PackFile(FileName$, *MemData, DataSize, PackLevel=5)    
   PackSize = DataSize * 1.2
   *MemPack = AllocateMemory(PackSize)
   compress2 (*MemPack, @PackSize, *MemData, DataSize, PackLevel)
   Zlib_CreateFullPath(FileName$)
   FileID = CreateFile(#PB_Any, FileName$)
   If FileID
      WriteLong(FileID, DataSize)
      WriteLong(FileID, PackSize)
      WriteData(FileID, *MemPack, PackSize)
      CloseFile(FileID)
   EndIf 
   FreeMemory(*MemPack)
   ProcedureReturn PackSize
EndProcedure
 
;-
;解压数据
Procedure Zlib_UnpackData(*MemPack, PackSize)    
   DataSize = PackSize * 100
   *MemData = AllocateMemory(DataSize)
   uncompress (*MemData, @DataSize, *MemPack, PackSize)
   *MemData = ReAllocateMemory(*MemData, DataSize)
   ProcedureReturn *MemData
EndProcedure

Procedure Zlib_UnpackMemory(*MemData, *pDataSize, *MemPack, PackSize)
   Result = uncompress(*MemData, *pDataSize, *MemPack, PackSize)
   ProcedureReturn Result 
EndProcedure
  
;从文件中加载压缩数据并解压(DataSize+PackSize+PackData) 
Procedure Zlib_UnpackFile(FileName$)      
   FileSize = FileSize(FileName$)
   FileID = ReadFile(#PB_Any, FileName$)
   If FileID
      DataSize = ReadLong(FileID)
      PackSize = ReadLong(FileID)
      *MemPack = AllocateMemory(PackSize)
      *MemData = AllocateMemory(DataSize)
      ReadData(FileID, *MemPack, PackSize)
      CloseFile(FileID)
      uncompress (*MemData, @DataSize, *MemPack, PackSize)
      FreeMemory(*MemPack)
      *MemData = ReAllocateMemory(*MemData, DataSize)
   EndIf 
   ProcedureReturn *MemData
EndProcedure
  

 
;- [Test]
TargetText$ = "PureBasic一套建立在'BASIC'基础上的新的'高级'语言. "         +#CRLF$
TargetText$ + "无论在Amiga或PC电脑上,都可以兼容其它的各种'BASIC' 编译器. " +#CRLF$
TargetText$ + "而且学习PureBasic非常的容易! "                              +#CRLF$
TargetText$ + "所以PureBasic已经获得了初学者和资深程序员的一致好评. "      +#CRLF$
TargetText$ + "这套软件编译时速度相当快. "                                 +#CRLF$
TargetText$ + "并且适用于Windows操作系统. "                                +#CRLF$
TargetText$ + "我们已经投入了大量的技术力量,"                              +#CRLF$
TargetText$ + "致力于开发一种速度更快,"                                    +#CRLF$
TargetText$ + "更可靠和更友好的系统语言. "                                 +#CRLF$
TargetText$ + "这种语言相当的简单,但提供了很多高级的用法,"                 +#CRLF$
TargetText$ + "如指针,结构,过程,动态链表等等.对于有经验的程序员,"          +#CRLF$
TargetText$ + "可以在无须声明的情况下,"                                    +#CRLF$
TargetText$ + "使用任意的系统结构或Window API函数."                        +#CRLF$
TargetText$ + "PureBasic 是一种便携式编程语言,"                            +#CRLF$
TargetText$ + "当前支持 AmigaOS (680x0 And PowerPC), Linux, MacOS X And Windows计算机系统. "+#CRLF$
TargetText$ + "这意味着编译出来的程序可以适用于本机系统,"                  +#CRLF$
TargetText$ + "也可以在其它系统上流畅的运行. "                             +#CRLF$
TargetText$ + "生成经优化过的高效的可执行文件,"                            +#CRLF$
TargetText$ + "并没有象虚拟机和解释器那样的瓶颈问题."                      +#CRLF$
TargetText$ + "完全手工优化的外接库,产生的命令往往比C++更快,或等同. "      +#CRLF$


DataSize = StringByteLength(TargetText$, #PB_Ascii)+1
*MemData = AllocateMemory(DataSize)
PokeS(*MemData, TargetText$, -1, #PB_Ascii)
PackSize = Zlib_PackFile("Text.pack", *MemData, DataSize, 9)    
Debug "DataSize = " + DataSize
Debug "PackSize = " + PackSize

*MemLoad = Zlib_UnpackFile("Text.pack")   
Debug PeekS(*MemData, -1, #PB_Ascii)



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 49
; FirstLine = 20
; Folding = R9
; EnableXP