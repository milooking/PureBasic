;***********************************
;迷路仟整理 2019.01.14
;ReadFile_读取文件.pb
;***********************************

FileName$ = "测试.txt"
FileID = ReadFile(#PB_Any, FileName$) 
If FileID
   Format = ReadStringFormat(FileID)      ;获取文本编码
   While Eof(FileID) = 0
      LineText$ = ReadString(FileID, Format)
      Debug LineText$
   Wend
   CloseFile(FileID)
Else
    MessageRequester("提示","无法打开文件!")
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP