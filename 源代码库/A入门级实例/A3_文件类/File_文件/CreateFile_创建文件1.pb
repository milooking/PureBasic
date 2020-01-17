;***********************************
;迷路仟整理 2019.01.26
;CreateFile_创建文件1
;***********************************


FileID = CreateFile(#PB_Any, "测试.txt")
If FileID
   WriteStringFormat(FileID, #PB_UTF8)             ;向文件写入文本编码类型
   For i = 1 To 10
      WriteStringN(FileID, "测试内容行-"+Str(i))   ;向文件写入文本,带换行功能
   Next
   For i = 1 To 10
      WriteString(FileID, "测试文本-"+Str(i)+",")  ;向文件写入文本,不带换行功能 
   Next
   CloseFile(FileID)                               ;关闭文件      
Else
   MessageRequester("提示", "创建文件出错!")
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP