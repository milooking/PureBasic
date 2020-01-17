;***********************************
;迷路仟整理 2019.01.29
;字符串转类型
;***********************************


 *MemAscii = Ascii("迷路仟")
ShowMemoryViewer(*MemAscii, 6)

Debug PeekS(*MemAscii, -1, #PB_Ascii)

*MemUtf8 = UTF8("迷路仟")
Debug PeekS(*MemUtf8, -1, #PB_UTF8)
; ShowMemoryViewer(*MemUtf8, 9)

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; EnableThread
; EnableXP