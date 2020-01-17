;***********************************
;迷路仟整理 2019.01.31
;FileStytem_打开文件夹
;***********************************

Procedure Window_OpenFolder(Folder$) 
   OpInfo.s="explore" 
   ShellExecute_(0,@OpInfo,@Folder$,0,0,#SW_SHOW) 
EndProcedure 
 
Window_OpenFolder ("c:") 
 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; Folding = -
; EnableXP