;***********************************
;迷路仟整理 2019.01.29
;Level_分级调试
;***********************************

;注意: Debug后面的代码,只在调试阶段有作用,编译时,不会编译到EXE或DLL里面
; 如: Debug LoadFont(0, "宋体", 14),调试阶段,是有加载字体的,
; 但编译到EXE或DLL后,是没有执行加载字体这个命令的


DebugLevel 1      ;指定测试类别

Debug "调试内容A!", 1
Debug "调试内容B!", 2
Debug "调试内容C!", 1
Debug "调试内容D!", 2






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableXP