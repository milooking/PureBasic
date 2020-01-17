;***********************************
;迷路仟整理 2019.01.29
;ClearDebugOutput_清空调试器
;***********************************

;注意: Debug后面的代码,只在调试阶段有作用,编译时,不会编译到EXE或DLL里面
; 如: Debug LoadFont(0, "宋体", 14),调试阶段,是有加载字体的,
; 但编译到EXE或DLL后,是没有执行加载字体这个命令的

For k = 1 To 10
   ClearDebugOutput()   ;清空调试器
   For i = 1 To 10
      Index + 1
      Debug Index
   Next
   Delay(500)
Next 
CloseDebugOutput()      ;关闭调试器



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP