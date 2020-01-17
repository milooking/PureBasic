;***********************************
;迷路仟整理 2019.01.26
;ReceiveHTTPMemory_接收缓存
;***********************************

InitNetwork()

*MemBuffer = ReceiveHTTPMemory("http://www.purebasic.com/index.php")
If *MemBuffer
   Size = MemorySize(*MemBuffer)
   Debug "接收到的内容为: " 
   Debug PeekS(*MemBuffer, Size, #PB_UTF8|#PB_ByteLength)
   FreeMemory(*MemBuffer)
Else
   Debug "接收失败"
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; EnableXP