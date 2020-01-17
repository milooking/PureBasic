;***********************************
;迷路仟整理 2019.01.26
;CreateFile_创建文件3
;***********************************


For i = 1 To 10
   Text$ + "测试内容行-"+Str(i) + #CRLF$   ; 带换行功能
Next
For i = 1 To 10
   Text$ +  "测试文本-"+Str(i)+","         ;不带换行功能 
Next
Lenght = StringByteLength(Text$, #PB_Ascii)
*MemData = AllocateMemory(10240)
PokeS(*MemData, Text$, -1, #PB_Ascii)
   
FileID = CreateFile(#PB_Any, "测试.txt")
If FileID
   WriteData(FileID, *MemData, Lenght)      ;一次性写入
   CloseFile(FileID)   
Else
   MessageRequester("提示", "创建文件出错!")
EndIf
FreeMemory(*MemData)


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP