;***********************************
;迷路仟整理 2019.01.28
;Gosub_Return 跳转与返回,这种强制跳过执行顺序的命令,尽量少用
;***********************************

; Gosub MyLabel 
;    
; MyLabel: 
;   ...
; Return

a = 1
b = 2
Gosub _TableOperate     ;跳转到标签处: _TableOperate
Debug a 

End 

_TableOperate: 
   a = b*2+a*3+(a+b) 
   a = a+a*a 
   Return               ;返回






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP