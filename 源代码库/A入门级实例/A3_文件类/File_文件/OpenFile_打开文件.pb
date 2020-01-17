;***********************************
;迷路仟整理 2019.01.27
;OpenFile_打开文件
;***********************************

FileID = OpenFile(#PB_Any, "测试.txt")   ;打开文本,写入不能用ReadFile()
If FileID
   LastPos = Lof(FileID)      ;获取文件最后位置
   FileSeek(FileID, LastPos)  ;跳到文件最后位置,实现追加效果
   WriteStringN(FileID, "这里是追加上来的文本.")
   CloseFile(FileID)
Else
  MessageRequester("提示", "打开文件出错")
EndIf

End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP