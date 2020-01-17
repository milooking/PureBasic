;***********************************
;迷路仟整理 2019.01.29
;ConsoleLocate_锁定位置
;***********************************

If OpenConsole()
   EnableGraphicalConsole(1)
   For i = 0 To 200
      ConsoleLocate(Random(79), Random(24))
      Print("★")
   Next
   ConsoleLocate(30, 10)
   PrintN("按[回车键]可以退出!")
   Input()
EndIf













; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableXP