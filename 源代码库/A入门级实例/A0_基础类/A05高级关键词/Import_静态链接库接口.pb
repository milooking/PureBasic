;***********************************
;迷路仟整理 2019.01.28
;Import 静态链接库接口
;***********************************


; Import "Filename"
;   FunctionName.<type>(<parameter>, [, <parameter> [= DefaultValue]...]) [As "SymbolName"]
;   ...
;   VariableName.<type> [As "SymbolName"]
; EndImport


Import "User32.lib"
   MessageBoxA(Window.i, Body$, Title$, Flags.i = 0)
   MsgBox(Window.i, Body$, Title$, Flags.i) As "_MessageBoxW@32"                                        
EndImport

  
MessageBoxA(0, "PureBasic", "提示1") ;ASCII模式,字符串出现乱码
MsgBox(0, "Miloo", "提示2", 0)


Import "User32.lib"
   MessageBoxW(Window.l, Body.p-unicode, Title.p-unicode, Flags.l=0)                                   
EndImport

MessageBoxW(0, "PureBasic", "提示")







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP