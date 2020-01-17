;***********************************
;迷路仟整理 2019.01.29
;ShowMemoryViewer_内存查看器
;***********************************


*MemData = AllocateMemory(1000)
If *MemData
    RandomData(*MemData, 1000)      
    ShowMemoryViewer(*MemData, 1000)   ;显示内存查看器
EndIf





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP