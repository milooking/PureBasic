;***********************************
;迷路仟整理 2019.02.02
;GetFolderSize_获取文件大小
;***********************************

Procedure.q Funciton_GetFileSize(FloderName$)  
   DirID = ExamineDirectory(#PB_Any, FloderName$, "")  
   If DirID  
      While NextDirectoryEntry(DirID)  
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File  
            FileSize.q + DirectoryEntrySize(DirID)  
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else 
            FileSize.q + Funciton_GetFileSize(FloderName$+DirectoryEntryName(DirID)+"\")  
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn FileSize  
EndProcedure  

FileSize.q = Funciton_GetFileSize("..\..\..\")

Debug "FileSize = " + FileSize
Debug "FileSize = " + StringField(FormatNumber(FileSize),1,".") + " byte"

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 21
; Folding = +
; EnableXP