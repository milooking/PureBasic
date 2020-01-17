;***********************************
;迷路仟整理 2019.01.29
;Disable_禁用调试器
;***********************************

;注意: Debug后面的代码,只在调试阶段有作用,编译时,不会编译到EXE或DLL里面
; 如: Debug LoadFont(0, "宋体", 14),调试阶段,是有加载字体的,
; 但编译到EXE或DLL后,是没有执行加载字体这个命令的


DisableDebugger   ;禁用调试器
   
Debug "这里Debug不了,现在被禁用了"

EnableDebugger    ;启用调试器

Debug "启用调试器成功!"



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP