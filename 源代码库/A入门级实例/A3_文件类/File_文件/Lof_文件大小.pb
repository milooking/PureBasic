;***********************************
;迷路仟整理 2019.01.26
;Lof_文件大小
;***********************************

FileID = ReadFile(#PB_Any, "测试.txt")
If FileID
   Length = Lof(FileID)                      ;获取文件大小
   *MemData = AllocateMemory(Length)         ;开辟内存块
   Bytes = ReadData(FileID, *MemData, Length);加载文件到内存
   CloseFile(FileID)                         ;关闭文件
   Debug "Lof 到的字节数: " + Str(Length)
   Debug "读取到的字节数: " + Str(Bytes)
   FreeMemory(*MemData)
Else
  MessageRequester("提示", "打开文件出错")
EndIf

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; EnableXP