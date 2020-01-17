;***********************************
;迷路仟整理 2019.02.02
;FormatFileSize_获取格式化文件大小
;***********************************

;获取格式化的文件文件大小(返回字符串,B至T)
Procedure$ FormatFileSize(FileSize.q)   
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

Debug FormatFileSize(4666065)


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP