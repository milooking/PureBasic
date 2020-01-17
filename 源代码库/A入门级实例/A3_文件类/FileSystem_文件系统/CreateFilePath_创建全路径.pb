;***********************************
;迷路仟整理 2019.02.02
;CreateFilePath_创建全路径.pb
;***********************************

;创建文件夹,支持多层创建.
Procedure CreateFilePath(FilePath$)  
   
   FilePath$ = ReplaceString(FilePath$, "/", "\")
   For x = 1 To CountString(FilePath$, "\")
      Floder$ = StringField(FilePath$, x, "\") + "\"
      SavePath$ + Floder$
      If FileSize(SavePath$) <> -2 And Mid(Floder$,2,1) <> ":"
         CreateDirectory(SavePath$)
         Result = #True
      EndIf 
   Next 
   ProcedureReturn Result
EndProcedure

; Debug CreateFilePath(".\Test\Test\Test\")

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP