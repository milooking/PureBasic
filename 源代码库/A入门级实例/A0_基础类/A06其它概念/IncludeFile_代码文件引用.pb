;***********************************
;迷路仟整理 2019.01.29
;IncludeFile_代码文件引用
;***********************************

;此代码文件不能运行
; IncludeFile  "Filename" 
; XIncludeFile "Filename"
; IncludePath "path" 
; IncludeBinary "filename" 


IncludeFile "Sources\myfile.pb"  ;不支持中文


IncludePath  "Sources\Data"
IncludeFile  "Sprite.pb"
XIncludeFile "Music.pb"


DataSection
   _MapLabel:
   IncludeBinary "Data\map.data"
EndDataSection 








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP