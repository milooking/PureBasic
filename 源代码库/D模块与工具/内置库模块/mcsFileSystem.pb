;��ע���Լ���TBManager���������ģ��(LIB),
;      ��[McsFileSystem]���Ƶ�[..\PureBasic-5.62-x86\PureLibraries\UserLibraries\]Ŀ¼��
;***********************************************************
;************   ��·���ÿ�ģ��:�ļ���ϵͳģ��   ************
;************ ����: ��·Ǫ/Miloo [QQ:714095563] ************
;************        2019�� [2018.11.07]       *************
;***********************************************************

XIncludeFile "FUN_NewList.pbi"
Global _GetEnumPath$
;-
; ö��ָ��·���µ������ļ����������ļ���
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
; ö��ָ��·���µ������ļ����������ļ���
ProcedureDLL mcsEnumFiles_(FilePath$, *pResetList) ; ö��ָ��·���µ������ļ�(�������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFiles_2(FilePath$, *pResetList, OffsetOf=0)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFilesA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFiles_3(FilePath$, *pResetList,OffsetOf=0, Suffix$="*")
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsEnumFiles_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
; ö��ָ��·����Ŀ¼�µ������ļ������������ļ���
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
ProcedureDLL mcsRootFiles_(FilePath$, *pResetList) ; ö��ָ��·���µ������ļ�(���������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFiles_2(FilePath$, *pResetList, OffsetOf=0)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFilesA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFiles_3(FilePath$, *pResetList, OffsetOf=0, Suffix$="*")
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsRootFiles_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure



;-
;-====================
; ö��ָ��·���µ������ļ��У��������ļ���
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
ProcedureDLL mcsEnumFolders_(FilePath$, *pResetList); ö��ָ��·���µ������ļ���(�������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), 0, 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumFolders_2(FilePath$, *pResetList, OffsetOf=0)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), OffsetOf, 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumFolders_3(FilePath$, *pResetList, OffsetOf=0, IsFixedPath=#False)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   CountFiles = MCS_Fun_EnumFolders(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
; ö��ָ��·����Ŀ¼�µ������ļ��У����������ļ���
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
ProcedureDLL mcsRootFolders_(FilePath$, *pResetList); ö��ָ��·���µ������ļ���(���������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), 0, 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootFolders_2(FilePath$, *pResetList, OffsetOf=0)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), OffsetOf, 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootFolders_3(FilePath$, *pResetList, OffsetOf=0, IsFixedPath=#False)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   CountFiles = MCS_Fun_RootFolders(FilePath$, ListFile$(), OffsetOf, AlignPath)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
; ö��ָ��·���µ������ļ�/�У��������ļ���
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
; ö��ָ��·���µ������ļ����������ļ���
ProcedureDLL mcsEnumDirectorys_(FilePath$, *pResetList); ö��ָ��·���µ������ļ�/��(�������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), 0)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDirectorys_2(FilePath$, *pResetList, OffsetOf=0)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   If Right(FilePath$, 1) <> "\" : FilePath$ = FilePath$+"\" : EndIf 
   CountFiles = MCS_Fun_EnumDirectorysA(FilePath$, ListFile$(), OffsetOf)
   ;======================
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDirectorys_3(FilePath$, *pResetList,OffsetOf=0, Suffix$="*")
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
   
EndProcedure

ProcedureDLL mcsEnumDirectorys_4(FilePath$, *pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False)
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure


;-
;-====================
ProcedureDLL mcsSetDragDorpState_(hWindow)   ; ���ô�������Ƿ�֧��ϵͳ�Ϸ�.
   ProcedureReturn DragAcceptFiles_(hWindow, #True) 
EndProcedure

ProcedureDLL mcsSetDragDorpState_2(hWindow, State=#True) 
   ProcedureReturn DragAcceptFiles_(hWindow, State) 
EndProcedure



;-
ProcedureDLL$ mcsGetDragDorpFile_() ;��ȡϵͳ�Ϸ��ļ�(���ļ�),�����ļ���.
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
ProcedureDLL mcsEnumDragDorpFiles_(*pResetList); ö��ϵͳ�Ϸ��ļ�(�������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_2(*pResetList, OffsetOf=0) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_3(*pResetList, OffsetOf=0, Suffix$="*") 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   ; �����ö��ȫ�����͵��ļ��������
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
   ; �����ö�ٿպ�꡵��ļ����͵������
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
      ;������ж����꡵������
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFiles_4(*pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   
   ; �����ö��ȫ�����͵��ļ��������
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
   ; �����ö�ٿպ�꡵��ļ����͵������
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
      ;������ж����꡵������
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL$ mcsGetDragDorpPath_() ;��ȡϵͳ�Ϸ��ļ���·��(����mcsEnumDragDorpFiles_()����,IsFixedPath=#Trueʱ��Ч).
   ProcedureReturn _GetEnumPath$
EndProcedure
;-
;-====================
ProcedureDLL mcsRootDragDorpFiles_(*pResetList) ; ö��ϵͳ�Ϸ��ļ�(���������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootDragDorpFiles_2(*pResetList, OffsetOf=0) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFiles_3(*pResetList, OffsetOf=0, Suffix$="*") 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   
   ; �����ö��ȫ�����͵��ļ��������
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
   ; �����ö�ٿպ�꡵��ļ����͵������
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
      ;������ж����꡵������
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFiles_4(*pResetList, OffsetOf=0, Suffix$="*", IsFixedPath=#False) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
   NewList ListFile$() 
   *pNewResetList = ResetList(ListFile$())
   mcs_CopyResetList(*pNewResetList, *pResetList)
   ;======================
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   If IsFixedPath = #True : AlignPath = Len(FilePath$) : EndIf 
   
   ; �����ö��ȫ�����͵��ļ��������
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
   ; �����ö�ٿպ�꡵��ļ����͵������
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
      ;������ж����꡵������
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
ProcedureDLL mcsEnumDragDorpFolders_(*pResetList) ; ö��ϵͳ�Ϸ��ļ���(�������ļ���)������ResetList()ָ��������(֧�ֽṹ��).
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsEnumDragDorpFolders_2(*pResetList, OffsetOf=0) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsEnumDragDorpFolders_3(*pResetList, OffsetOf=0, IsFixedPath=#False) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

;-
;-====================
ProcedureDLL mcsRootDragDorpFolders_(*pResetList) ; ö��ϵͳ�Ϸ��ļ���(���������ļ���)������ResetList()ָ��������(֧�ֽṹ��). 
   
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles

EndProcedure

ProcedureDLL mcsRootDragDorpFolders_2(*pResetList, OffsetOf=0) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
   mcs_FreeResetList(*pNewResetList)
   FreeList(ListFile$())
   ProcedureReturn CountFiles
EndProcedure

ProcedureDLL mcsRootDragDorpFolders_3(*pResetList, OffsetOf=0, IsFixedPath=#False) 
   ; �ڲ�����һ������Ȼ���б��Ʊ����뵽��*pResetList����
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
   ;��ԭ�ڲ�����������Ȼ����ע������
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

ProcedureDLL$ mcsFileSizeN_(FileSize.q)   ;��ȡ��ʽ�����ļ��ļ���С(�����ַ���,B��T)
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

ProcedureDLL.q mcsFolderSize_(FileName$)  ;��ö�ļ������ļ��Ĵ�С(�������ļ���).
   FileSize.q = FileSize(FileName$)
   If FileSize = -2
      If Right(FileName$, 1) = "\" : FileName$+"\" : EndIf    
      FileSize = MCS_Fun_FileSize(FileName$) 
   EndIf 
   ProcedureReturn FileSize
EndProcedure

ProcedureDLL.q mcsRootSize_(FileName$)  ;��ö�ļ������ļ��Ĵ�С(���������ļ���).
   FileSize.q = FileSize(FileName$)
   If FileSize >= 0 : FileName$ = GetPathPart(FileName$) : EndIf 
   If Right(FileName$, 1) = "\" : FileName$+"\" : EndIf    
   FileSize = MCS_Fun_FileSize_Root(FileName$) 
   ProcedureReturn FileSize
EndProcedure




ProcedureDLL$ mcsGetSamePath_(FileName1$, FileName2$) ;��ȡ�����ļ������൱·���Ĳ���.
   
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
ProcedureDLL mcsGetFileIcon_(FileName$) ;��ȡ�ļ���Ĭ�ϵ�ICOͼ����.
   SHGetFileInfo_(FileName$, 0, @FileInfo.SHFILEINFO, SizeOf(SHFILEINFO), $20|#SHGFI_ICON|#SHGFI_LARGEICON)
   ProcedureReturn FileInfo\hIcon
EndProcedure


ProcedureDLL mcsOpenFolder_(FolderName$) ;���ļ���.
   ProcedureReturn ShellExecute_(0, "open",  @FolderName$, 0, 0, #SW_SHOW) 
EndProcedure

ProcedureDLL$ mcsRenameSuffix_(FileName$, NewSuffix$) ;���¶����ļ����(ֻ�޸��ַ���).
   TempSuffix$ = GetExtensionPart(FileName$)
   If TempSuffix$ <> NewSuffix$ 
      FileName$ = Left(FileName$, Len(FileName$) - Len(TempSuffix$)) + NewSuffix$
   EndIf 
   ProcedureReturn FileName$
EndProcedure


ProcedureDLL mcsCreateDirectory_(FileName$)  ;�����ļ���,֧�ֶ�㴴��.
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