;***********************************
;迷路仟整理 2019.01.26
;CreateFile_创建文件
;***********************************


MessageRequester("提示", "本程序将在根目录下产生[测试.pb]的文件")

; 创建文件
FileID = CreateFile(#PB_Any, "测试.txt")
If FileID
   WriteStringFormat(FileID, #PB_UTF8)                        ;向文件写入文本编码类型
   WriteStringN(FileID, "欢迎使用[迷路PureBasic实例库工具]")  ;向文件写入文本,带换行功能
   WriteString(FileID, "这里没有换行:")                       ;向文件写入文本,不带换行功能
   WriteString(FileID, "PureBasic.")
   CloseFile(FileID)                                          ;关闭文件
Else
   MessageRequester("提示", "创建文件出错!")
   End
EndIf

FileID = ReadFile(#PB_Any, "测试.txt")
If FileID
   Format = ReadStringFormat(FileID)         ;判断文本文件的编码类型
   LineText$ =  ReadString(FileID, Format)   ;读取一行文本
   MessageRequester("提示", "读取到的内容: "+LineText$)
   CloseFile(FileID)                         ;关闭文件
Else
  MessageRequester("提示", "打开文件出错")
EndIf

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP