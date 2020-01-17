;【注】自己用TBManager编译成内置模块(LIB),
;      或将[McsFileSystem]复制到[..\PureBasic-5.62-x86\PureLibraries\UserLibraries\]目录中
;***********************************************************
;************   迷路内置库模块:文件夹系统模块   ************
;************ 作者: 迷路仟/Miloo [QQ:714095563] ************
;************        2019版 [2018.11.07]       *************
;***********************************************************

XIncludeFile "FUN_NewList.pbi"
Global _GetEnumPath$
;-
; 枚举指定路径下的所有文件，包括子文件夹
Procedure MCS_Fun_EnumFilesA(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + MCS_Fun_EnumFilesA(FilePath$+FileName$+"\", ListFile$(), OffsetOf, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumFilesB(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If GetExtensionPart(FileName$) = ""
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + MCS_Fun_EnumFilesB(FilePath$+FileName$+"\", ListFile$(), OffsetOf, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumFilesC(FilePath$, List ListFile$(), OffsetOf, Suffix$, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If LCase(GetExtensionPart(FileName$)) = Suffix$
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + MCS_Fun_EnumFilesC(FilePath$+FileName$+"\", ListFile$(), OffsetOf, Suffix$, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumFilesD(FilePath$, List ListFile$(), OffsetOf, List ListSuffix$(), AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File 
            TempSuffix$ = LCase(GetExtensionPart(FileName$))
            ForEach ListSuffix$()
               If ListSuffix$()  = TempSuffix$
                  Count + 1
                  FullName$ = FilePath$+FileName$
                  If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FullName$
                  Break
                EndIf 
            Next  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + MCS_Fun_EnumFilesD(FilePath$+FileName$+"\", ListFile$(), OffsetOf, ListSuffix$(), AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-
; 枚举指定路径下的所有文件，包括子文件夹
ProcedureDLL mcsEnumFiles_(FilePath$, *pResetList) ; 枚举指定路径下的所有文件(包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFiles_2(FilePath$, *pResetList, OffsetOf=0)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFiles_3(FilePath$, *pResetList,OffsetOf=0, Suffix$="*")
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), OffsetOf)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_EnumFilesB(FilePath$, ListFile$(), OffsetOf)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_EnumFilesC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$))
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_EnumFilesD(FilePath$, ListFile$(), OffsetOf, ListSuffix$())
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsEnumFiles_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_EnumFilesB(FilePath$, ListFile$(), OffsetOf, AlignPath)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|"
         Suffix$ = Left(Suffix$, Len(Suffix$)-1) 
      EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_EnumFilesC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$), AlignPath)
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_EnumFilesD(FilePath$, ListFile$(), OffsetOf, ListSuffix$(), AlignPath)
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
; 枚举指定路径根目录下的所有文件，不包括子文件夹
Procedure MCS_Fun_RootFilesA(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
        EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_RootFilesB(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If GetExtensionPart(FileName$) = ""
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_RootFilesC(FilePath$, List ListFile$(), OffsetOf, Suffix$, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If LCase(GetExtensionPart(FileName$)) = Suffix$
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_RootFilesD(FilePath$, List ListFile$(), OffsetOf, List ListSuffix$(), AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File 
            TempSuffix$ = LCase(GetExtensionPart(FileName$))
            ForEach ListSuffix$()
               If ListSuffix$()  = TempSuffix$
                  Count + 1
                  FullName$ = FilePath$+FileName$
                  If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FullName$
                  Break
                EndIf 
            Next  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-
ProcedureDLL mcsRootFiles_(FilePath$, *pResetList) ; 枚举指定路径下的所有文件(不包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFiles_2(FilePath$, *pResetList, OffsetOf=0)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFiles_3(FilePath$, *pResetList, OffsetOf=0, Suffix$="*")
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), OffsetOf)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_RootFilesB(FilePath$, ListFile$(), OffsetOf)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|"
         Suffix$ = Left(Suffix$, Len(Suffix$)-1) 
      EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_RootFilesC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$))
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_RootFilesD(FilePath$, ListFile$(), OffsetOf, ListSuffix$())
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsRootFiles_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_RootFilesB(FilePath$, ListFile$(), OffsetOf, AlignPath)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|"
         Suffix$ = Left(Suffix$, Len(Suffix$)-1) 
      EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_RootFilesC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$), AlignPath)
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_RootFilesD(FilePath$, ListFile$(), OffsetOf, ListSuffix$(), AlignPath)
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure



;-
;-====================
; 枚举指定路径下的所有文件夹，包括子文件夹
Procedure MCS_Fun_EnumFolders(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
            Count + MCS_Fun_EnumFolders(FilePath$+FileName$+"\", ListFile$(), OffsetOf, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-
ProcedureDLL mcsEnumFolders_(FilePath$, *pResetList); 枚举指定路径下的所有文件夹(包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), 0, 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumFolders_2(FilePath$, *pResetList, OffsetOf=0)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), OffsetOf, 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFolders_3(FilePath$, *pResetList, OffsetOf=0, IsFixedPath=#False)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
; 枚举指定路径根目录下的所有文件夹，不包括子文件夹
Procedure MCS_Fun_RootFolders(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-
ProcedureDLL mcsRootFolders_(FilePath$, *pResetList); 枚举指定路径下的所有文件夹(不包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), 0, 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootFolders_2(FilePath$, *pResetList, OffsetOf=0)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), OffsetOf, 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFolders_3(FilePath$, *pResetList, OffsetOf=0, IsFixedPath=#False)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
; 枚举指定路径下的所有文件/夹，包括子文件夹
Procedure MCS_Fun_EnumDirectorysA(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
            Count + MCS_Fun_EnumDirectorysA(FilePath$+FileName$+"\", ListFile$(), OffsetOf, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumDirectorysB(FilePath$, List ListFile$(), OffsetOf, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If GetExtensionPart(FileName$) = ""
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else 
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
            Count + MCS_Fun_EnumDirectorysB(FilePath$+FileName$+"\", ListFile$(), OffsetOf, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumDirectorysC(FilePath$, List ListFile$(), OffsetOf, Suffix$, AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            If LCase(GetExtensionPart(FileName$)) = Suffix$
               Count + 1
               FullName$ = FilePath$+FileName$
               If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FullName$
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
            Count + MCS_Fun_EnumDirectorysC(FilePath$+FileName$+"\", ListFile$(), OffsetOf, Suffix$, AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure MCS_Fun_EnumDirectorysD(FilePath$, List ListFile$(), OffsetOf, List ListSuffix$(), AlignPath=0)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File 
            TempSuffix$ = LCase(GetExtensionPart(FileName$))
            ForEach ListSuffix$()
               If ListSuffix$()  = TempSuffix$
                  Count + 1
                  FullName$ = FilePath$+FileName$
                  If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FullName$
                  Break
                EndIf 
            Next  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else  
            Count + 1
            FullName$ = FilePath$+FileName$
            If AlignPath : FullName$ = Mid(FullName$, AlignPath+1) : EndIf
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FullName$
            Count + MCS_Fun_EnumDirectorysD(FilePath$+FileName$+"\", ListFile$(), OffsetOf, ListSuffix$(), AlignPath)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-
; 枚举指定路径下的所有文件，包括子文件夹
ProcedureDLL mcsEnumDirectorys_(FilePath$, *pResetList); 枚举指定路径下的所有文件/夹(包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), 0)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDirectorys_2(FilePath$, *pResetList, OffsetOf=0)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDirectorys_3(FilePath$, *pResetList,OffsetOf=0, Suffix$="*")
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), OffsetOf)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_EnumDirectorysB(FilePath$, ListFile$(), OffsetOf)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_EnumDirectorysC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$))
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_EnumDirectorysD(FilePath$, ListFile$(), OffsetOf, ListSuffix$())
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsEnumDirectorys_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ElseIf Suffix$ = ""
      CountFiles = MCS_Fun_EnumDirectorysB(FilePath$, ListFile$(), OffsetOf, AlignPath)
   Else
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|"
         Suffix$ = Left(Suffix$, Len(Suffix$)-1) 
      EndIf 
      
      If FindString(Suffix$, "|", 1) = 0
         CountFiles = MCS_Fun_EnumDirectorysC(FilePath$, ListFile$(), OffsetOf, LCase(Suffix$), AlignPath)
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 
         CountFiles = MCS_Fun_EnumDirectorysD(FilePath$, ListFile$(), OffsetOf, ListSuffix$(), AlignPath)
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
      
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
ProcedureDLL mcsSetDragDorpState_(hWindow)   ; 设置窗体界面是否支持系统拖放.
   ProcedureReturn DragAcceptFiles_(hWindow, #True) 
EndProcedure

ProcedureDLL mcsSetDragDorpState_2(hWindow, State=#True) 
   ProcedureReturn DragAcceptFiles_(hWindow, State) 
EndProcedure



;-
ProcedureDLL$ mcsGetDragDorpFile_() ;获取系统拖放文件(单文件),返回文件名.
   DroppedID = EventwParam()  
   CountFiles = DragQueryFile_(DroppedID, $FFFFFFFF, "", 0) 
   If CountFiles
      LenFileName  = DragQueryFile_(DroppedID, 0, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, 0, FileName$, LenFileName+1) 
   EndIf 
   DragFinish_(DroppedID) 
   ProcedureReturn FileName$
EndProcedure

;-
;-====================
ProcedureDLL mcsEnumDragDorpFiles_(*pResetList); 枚举系统拖放文件(包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) >= 0           
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+0
         *p\s = FileName$
         CountFiles + 1
      ElseIf FileSize(FileName$) = -2 
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         CountFiles + MCS_Fun_EnumFilesA(FileName$, ListFile$(), 0)
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_2(*pResetList, OffsetOf=0) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) >= 0           
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+OffsetOf
         *p\s = FileName$
         CountFiles + 1
      ElseIf FileSize(FileName$) = -2 
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         CountFiles + MCS_Fun_EnumFilesA(FileName$, ListFile$(), OffsetOf, 0)
      EndIf 
   Next  
      
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_3(*pResetList, OffsetOf=0, Suffix$="*") 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   ; 如果是枚举全部类型的文件的情况下
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0           
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FileName$
            CountFiles + 1
         ElseIf FileSize(FileName$) = -2 
            If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
            CountFiles + MCS_Fun_EnumFilesA(FileName$, ListFile$(), OffsetOf, 0)
         EndIf 
      Next  
   ; 如果是枚举空后辍的文件类型的情况下
   ElseIf Suffix$ = ""
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0  
            If GetExtensionPart(FileName$) = ""        
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FileName$
               CountFiles + 1
            EndIf 
         ElseIf FileSize(FileName$) = -2 
            If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
            CountFiles + MCS_Fun_EnumFilesB(FileName$, ListFile$(), OffsetOf, 0)
         EndIf 
      Next  
   Else
      ;如果是有多个后辍的情况下
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 

      If FindString(Suffix$, "|", 1) = 0
         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0  
               If LCase(GetExtensionPart(FileName$)) = Suffix$        
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FileName$
                  CountFiles + 1
               EndIf 
            ElseIf FileSize(FileName$) = -2 
               If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
               CountFiles + MCS_Fun_EnumFilesC(FileName$, ListFile$(), OffsetOf, LCase(Suffix$), 0)
            EndIf 
         Next  
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 

         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0 
               TempSuffix$ = LCase(GetExtensionPart(FileName$))
               ForEach ListSuffix$()   
                  If ListSuffix$() = TempSuffix$
                     *pAddElement = AddElement(ListFile$())
                     *p.string = *pAddElement+OffsetOf
                     *p\s = FileName$
                     CountFiles + 1
                     Break
                  EndIf 
               Next  
            ElseIf FileSize(FileName$) = -2 
               If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
               CountFiles + MCS_Fun_EnumFilesD(FileName$, ListFile$(), OffsetOf, ListSuffix$(), 0)
            EndIf 
         Next  
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_4(*pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   
   ; 如果是枚举全部类型的文件的情况下
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         _GetEnumPath$ = GetPathPart(FileName$)
         If IsFixedPath = #True : AlignPath = Len(_GetEnumPath$) : EndIf 
         If FileSize(FileName$) >= 0     
            If AlignPath : FileName$ = Mid(FileName$, AlignPath+1) : EndIf      
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FileName$
            CountFiles + 1
         ElseIf FileSize(FileName$) = -2 
            If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
            CountFiles + MCS_Fun_EnumFilesA(FileName$, ListFile$(), OffsetOf, AlignPath)
         EndIf 
      Next  
   ; 如果是枚举空后辍的文件类型的情况下
   ElseIf Suffix$ = ""
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         _GetEnumPath$ = GetPathPart(FileName$)
         If IsFixedPath = #True : AlignPath = Len(_GetEnumPath$) : EndIf 
         If FileSize(FileName$) >= 0  
            If GetExtensionPart(FileName$) = ""  
               If AlignPath : FileName$ = Mid(FileName$, AlignPath+1) : EndIf       
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FileName$
               CountFiles + 1
            EndIf 
         ElseIf FileSize(FileName$) = -2 
            If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
            CountFiles + MCS_Fun_EnumFilesB(FileName$, ListFile$(), OffsetOf, AlignPath)
         EndIf 
      Next  
   Else
      ;如果是有多个后辍的情况下
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 

      If FindString(Suffix$, "|", 1) = 0
         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            _GetEnumPath$ = GetPathPart(FileName$)
            If IsFixedPath = #True : AlignPath = Len(_GetEnumPath$) : EndIf 
            If FileSize(FileName$) >= 0  
               If AlignPath : FileName$ = Mid(FileName$, AlignPath+1) : EndIf 
               If LCase(GetExtensionPart(FileName$)) = Suffix$        
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FileName$
                  CountFiles + 1
               EndIf 
            ElseIf FileSize(FileName$) = -2 
               If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
               CountFiles + MCS_Fun_EnumFilesC(FileName$, ListFile$(), OffsetOf, LCase(Suffix$), AlignPath)
            EndIf 
         Next  
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 

         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            _GetEnumPath$ = GetPathPart(FileName$)
            If IsFixedPath = #True : AlignPath = Len(_GetEnumPath$) : EndIf 
            If FileSize(FileName$) >= 0 
               If AlignPath : FileName$ = Mid(FileName$, AlignPath+1) : EndIf 
               TempSuffix$ = LCase(GetExtensionPart(FileName$))
               ForEach ListSuffix$()   
                  If ListSuffix$() = TempSuffix$
                     *pAddElement = AddElement(ListFile$())
                     *p.string = *pAddElement+OffsetOf
                     *p\s = FileName$
                     CountFiles + 1
                     Break
                  EndIf 
               Next  
            ElseIf FileSize(FileName$) = -2 
               If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
               CountFiles + MCS_Fun_EnumFilesD(FileName$, ListFile$(), OffsetOf, ListSuffix$(), AlignPath)
            EndIf 
         Next  
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL$ mcsGetDragDorpPath_() ;获取系统拖放文件的路径(用在mcsEnumDragDorpFiles_()后面,IsFixedPath=#True时有效).
   ProcedureReturn _GetEnumPath$
EndProcedure
;-
;-====================
ProcedureDLL mcsRootDragDorpFiles_(*pResetList) ; 枚举系统拖放文件(不包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) >= 0           
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+0
         *p\s = FileName$
         CountFiles + 1
;       ElseIf FileSize(FileName$) = -2 
;          If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;          CountFiles + MCS_Fun_RootFilesA(FileName$, ListFile$(), 0)
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootDragDorpFiles_2(*pResetList, OffsetOf=0) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) >= 0           
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+OffsetOf
         *p\s = FileName$
         CountFiles + 1
;       ElseIf FileSize(FileName$) = -2 
;          If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;          CountFiles + MCS_Fun_RootFilesA(FileName$, ListFile$(), OffsetOf, 0)
      EndIf 
   Next  
      
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFiles_3(*pResetList, OffsetOf=0, Suffix$="*") 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   ; 如果是枚举全部类型的文件的情况下
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0           
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FileName$
            CountFiles + 1
;          ElseIf FileSize(FileName$) = -2 
;             If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;             CountFiles + MCS_Fun_RootFilesA(FileName$, ListFile$(), OffsetOf, 0)
         EndIf 
      Next  
   ; 如果是枚举空后辍的文件类型的情况下
   ElseIf Suffix$ = ""
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0  
            If GetExtensionPart(FileName$) = ""        
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FileName$
               CountFiles + 1
            EndIf 
;          ElseIf FileSize(FileName$) = -2 
;             If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;             CountFiles + MCS_Fun_RootFilesB(FileName$, ListFile$(), OffsetOf, 0)
         EndIf 
      Next  
   Else
      ;如果是有多个后辍的情况下
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 

      If FindString(Suffix$, "|", 1) = 0
         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0  
               If LCase(GetExtensionPart(FileName$)) = Suffix$        
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FileName$
                  CountFiles + 1
               EndIf 
;             ElseIf FileSize(FileName$) = -2 
;                If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;                CountFiles + MCS_Fun_RootFilesC(FileName$, ListFile$(), OffsetOf, LCase(Suffix$), 0)
            EndIf 
         Next  
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 

         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0 
               TempSuffix$ = LCase(GetExtensionPart(FileName$))
               ForEach ListSuffix$()   
                  If ListSuffix$() = TempSuffix$
                     *pAddElement = AddElement(ListFile$())
                     *p.string = *pAddElement+OffsetOf
                     *p\s = FileName$
                     CountFiles + 1
                     Break
                  EndIf 
               Next  
;             ElseIf FileSize(FileName$) = -2 
;                If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;                CountFiles + MCS_Fun_RootFilesD(FileName$, ListFile$(), OffsetOf, ListSuffix$(), 0)
            EndIf 
         Next  
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFiles_4(*pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   
   ; 如果是枚举全部类型的文件的情况下
   If Suffix$ = "*" Or Suffix$ = ".*" Or Suffix$ = "*.*"
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0           
            *pAddElement = AddElement(ListFile$())
            *p.string = *pAddElement+OffsetOf
            *p\s = FileName$
            CountFiles + 1
;          ElseIf FileSize(FileName$) = -2 
;             If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;             CountFiles + MCS_Fun_RootFilesA(FileName$, ListFile$(), OffsetOf, AlignPath)
         EndIf 
      Next  
   ; 如果是枚举空后辍的文件类型的情况下
   ElseIf Suffix$ = ""
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         If FileSize(FileName$) >= 0  
            If GetExtensionPart(FileName$) = ""        
               *pAddElement = AddElement(ListFile$())
               *p.string = *pAddElement+OffsetOf
               *p\s = FileName$
               CountFiles + 1
            EndIf 
;          ElseIf FileSize(FileName$) = -2 
;             If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;             CountFiles + MCS_Fun_RootFilesB(FileName$, ListFile$(), OffsetOf, AlignPath)
         EndIf 
      Next  
   Else
      ;如果是有多个后辍的情况下
      Suffix$ = LCase(Suffix$)
      If Right(Suffix$, 1) = "|" : Suffix$ = Left(Suffix$, Len(Suffix$)-1) : EndIf 

      If FindString(Suffix$, "|", 1) = 0
         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0  
               If LCase(GetExtensionPart(FileName$)) = Suffix$        
                  *pAddElement = AddElement(ListFile$())
                  *p.string = *pAddElement+OffsetOf
                  *p\s = FileName$
                  CountFiles + 1
               EndIf 
;             ElseIf FileSize(FileName$) = -2 
;                If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;                CountFiles + MCS_Fun_RootFilesC(FileName$, ListFile$(), OffsetOf, LCase(Suffix$), AlignPath)
            EndIf 
         Next  
      Else
         CountSuffix = CountString(Suffix$, "|")+1
         NewList ListSuffix$()
         For k = 1 To CountSuffix
            AddElement(ListSuffix$()) 
            ListSuffix$() = StringField(Suffix$, k, "|")
         Next 

         For k = 0 To GetCount - 1  
            LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
            FileName$ = Space(LenFileName)  
            DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
            If FileSize(FileName$) >= 0 
               TempSuffix$ = LCase(GetExtensionPart(FileName$))
               ForEach ListSuffix$()   
                  If ListSuffix$() = TempSuffix$
                     *pAddElement = AddElement(ListFile$())
                     *p.string = *pAddElement+OffsetOf
                     *p\s = FileName$
                     CountFiles + 1
                     Break
                  EndIf 
               Next  
;             ElseIf FileSize(FileName$) = -2 
;                If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
;                CountFiles + MCS_Fun_RootFilesD(FileName$, ListFile$(), OffsetOf, ListSuffix$(), AlignPath)
            EndIf 
         Next  
         FreeList(ListSuffix$())
      EndIf 
   EndIf 
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
ProcedureDLL mcsEnumDragDorpFolders_(*pResetList) ; 枚举系统拖放文件夹(包括子文件夹)并返回ResetList()指定的链表(支持结构体).
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2 
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         CountFiles + MCS_Fun_EnumFolders(FileName$, ListFile$(), 0, 0)
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumDragDorpFolders_2(*pResetList, OffsetOf=0) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2 
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         CountFiles + MCS_Fun_EnumFolders(FileName$, ListFile$(), OffsetOf, 0)
      EndIf 
   Next  
      
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFolders_3(*pResetList, OffsetOf=0, IsFixedPath=#False) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2 
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         CountFiles + MCS_Fun_EnumFolders(FileName$, ListFile$(), OffsetOf, AlignPath)
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
ProcedureDLL mcsRootDragDorpFolders_(*pResetList) ; 枚举系统拖放文件夹(不包括子文件夹)并返回ResetList()指定的链表(支持结构体). 
   
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2   
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+0
         *p\s = FileName$
         CountFiles + 1
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootDragDorpFolders_2(*pResetList, OffsetOf=0) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2           
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+OffsetOf
         *p\s = FileName$
         CountFiles + 1
      EndIf 
   Next  
      
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFolders_3(*pResetList, OffsetOf=0, IsFixedPath=#False) 
   ; 内部构建一个链表，然后将列表移表到导入到的*pResetList链表
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      If FileSize(FileName$) = -2           
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         If AlignPath : FileName$ = Mid(FileName$, AlignPath+1) : EndIf
         *pAddElement = AddElement(ListFile$())
         *p.string = *pAddElement+OffsetOf
         *p\s = FileName$
         CountFiles + 1
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   ;======================
   ;还原内部构建的链表，然后将它注销掉，
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================

Procedure.q MCS_Fun_FileSize(FloderName$)  
   DirID = ExamineDirectory(#PB_Any, FloderName$, "")  
   If DirID  
      While NextDirectoryEntry(DirID)  
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            FileSize.q + DirectoryEntrySize(DirID)  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else 
            FileSize.q + MCS_Fun_FileSize(FloderName$+DirectoryEntryName(DirID)+"\")  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn FileSize  
EndProcedure  

Procedure.q MCS_Fun_FileSize_Root(FloderName$)  
   DirID = ExamineDirectory(#PB_Any, FloderName$, "")  
   If DirID  
      While NextDirectoryEntry(DirID)  
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            FileSize.q + DirectoryEntrySize(DirID)  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn FileSize  
EndProcedure  

   

   
   



;-

ProcedureDLL$ mcsFileSizeN_(FileSize.q)   ;获取格式化的文件文件大小(返回字符串,B至T)
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" B" : EndIf 
   FileSizeD.d = FileSize / 1024
   If FileSizeD < 900 : ProcedureReturn StrF(FileSizeD, 2)+" K" : EndIf 
   FileSizeD / 1024
   If FileSizeD < 900 : ProcedureReturn StrF(FileSizeD, 2)+" M" : EndIf 
   FileSizeD / 1024
   If FileSizeD < 900 : ProcedureReturn StrF(FileSizeD, 2)+" G" : EndIf 
   FileSizeD / 1024
   If FileSizeD < 900 : ProcedureReturn StrF(FileSizeD, 2)+" T" : EndIf 
EndProcedure

ProcedureDLL.q mcsFolderSize_(FileName$)  ;举枚文件夹中文件的大小(包括子文件夹).
   FileSize.q = FileSize(FileName$)
   If FileSize = -2
      If Right(FileName$, 1) = "\" : FileName$+"\" : EndIf    
      FileSize = MCS_Fun_FileSize(FileName$) 
   EndIf 
   ProcedureReturn FileSize
EndProcedure

ProcedureDLL.q mcsRootSize_(FileName$)  ;举枚文件夹中文件的大小(不包括子文件夹).
   FileSize.q = FileSize(FileName$)
   If FileSize >= 0 : FileName$ = GetPathPart(FileName$) : EndIf 
   If Right(FileName$, 1) = "\" : FileName$+"\" : EndIf    
   FileSize = MCS_Fun_FileSize_Root(FileName$) 
   ProcedureReturn FileSize
EndProcedure




ProcedureDLL$ mcsGetSamePath_(FileName1$, FileName2$) ;获取两个文件夹中相当路径的部分.
   
   FilePath1$ = GetPathPart(FileName1$)
   FilePath2$ = GetPathPart(FileName2$)
   If FilePath1$ = FilePath2$
      ProcedureReturn FilePath1$
   ElseIf FilePath1$ = #Null$
      ProcedureReturn #Null$
   ElseIf FilePath2$ = #Null$ 
      ProcedureReturn #Null$
   Else 
      If Right(FilePath1$, 1) <> "\" 
         FilePath1$+"\" 
         If FilePath1$ = FilePath2$ : ProcedureReturn FilePath1$ : EndIf 
      EndIf 
      If Right(FilePath2$, 1) <> "\" 
         FilePath2$+"\"
         If FilePath1$ = FilePath2$ : ProcedureReturn FilePath1$ : EndIf 
      EndIf 
      Count = CountString(FilePath1$, "\") 
      SamePath$ = ""
      For k = 1 To Count
         Part1$ = StringField(FilePath1$, k, "\")
         Part2$ = StringField(FilePath2$, k, "\")
         If Part1$ = Part2$
            SamePath$+Part1$+"\"
         Else 
            Break
         EndIf 
      Next 
      ProcedureReturn SamePath$  
   EndIf 
EndProcedure

;-
ProcedureDLL mcsGetFileIcon_(FileName$) ;获取文件的默认的ICO图标句柄.
   SHGetFileInfo_(FileName$, 0, @FileInfo.SHFILEINFO, SizeOf(SHFILEINFO), $20|#SHGFI_ICON|#SHGFI_LARGEICON)
   ProcedureReturn FileInfo\hIcon
EndProcedure


ProcedureDLL mcsOpenFolder_(FolderName$) ;打开文件夹.
   ProcedureReturn ShellExecute_(0, "open",  @FolderName$, 0, 0, #SW_SHOW) 
EndProcedure

ProcedureDLL$ mcsRenameSuffix_(FileName$, NewSuffix$) ;重新定义文件后辍(只修改字符串).
   TempSuffix$ = GetExtensionPart(FileName$)
   If TempSuffix$ <> NewSuffix$ 
      FileName$ = Left(FileName$, Len(FileName$) - Len(TempSuffix$)) + NewSuffix$
   EndIf 
   ProcedureReturn FileName$
EndProcedure


ProcedureDLL mcsCreateDirectory_(FileName$)  ;创建文件夹,支持多层创建.
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





; IDE Options = PureBasic 5.62 (Windows - x86)
; ExecutableFormat = Shared dll
; CursorPosition = 8
; Folding = AAAAAcIAA9-
; EnableXP