;***********************************
;迷路仟整理 2019.01.29
;DataSection_数据包含
;***********************************


;数据包含,支持,整型数值,浮点数值,字符串,标签,函数,文件数据

Procedure Max(Number, Number2)

EndProcedure
  
_Label:

DataSection
   Data.l 100, 200, -250, -452, 145
   Data.f 10.45684, 5584.4481488
   Data.s "Hello", "This", "is ", "What ?"
   Data.i ?_Label, @Max()
_ICON_PureBasic:
   IncludeBinary ".\PureBasic.ico" 
EndDataSection



;Read加载
Restore _Bin_String
Read.s MyFirstData$
Read.s MySecondData$

Restore _Bin_Number
Read.l a
Read.l b

Debug MyFirstData$
Debug a

;Copy加载
Dim DimValue(4)
CopyMemory(?_Bin_Number, DimValue(), 5*4)
Debug DimValue(0)

;Catch加载
ImageID = CatchImage(#PB_Any, ?_ICON_Image)
Debug "ImageID = "+Str(ImageID)

DataSection
_Bin_Number:    
   Data.l 100, 200, -250, -452, 145

_Bin_String:
   Data.s "Hello", "This", "is ", "What ?"

_ICON_Image:
   IncludeBinary ".\PureBasic.ico" 
EndDataSection














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = 8
; EnableXP