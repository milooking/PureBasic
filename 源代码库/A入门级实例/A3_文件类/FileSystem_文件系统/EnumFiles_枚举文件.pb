;***********************************
;迷路仟整理 2019.01.14
;EnumFiles_枚举文件
;***********************************

Procedure Funciton_EnumFiles(FilePath$, List ListFile$())
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID)  
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File   ;获取文件名
            Count + 1      
            AddElement(ListFile$())               
            ListFile$() = FilePath$+FileName$
         ElseIf DirectoryEntryName(DirID) = "."                   ;排除DOS兼容格式
         ElseIf DirectoryEntryName(DirID) = ".."                  ;排除DOS兼容格式  
         Else                                                     ;文件夹
            Count + Funciton_EnumFiles(FilePath$+FileName$+"\", ListFile$())  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

;-=========================
NewList ListFiles$()
Count = Funciton_EnumFiles("..\..\..\", ListFiles$())
ForEach ListFiles$()
   Debug ListFiles$()
Next 
Debug Count

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP