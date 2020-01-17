;***********************************
;迷路仟整理 2019.01.23
;CatchImage_提取图像
;***********************************

Enumeration
   #winScreen
   #imgScreen1
   #imgScreen2
   #picScreen1
   #picScreen2
   #picScreen3
EndEnumeration



;1.从EXE的包含资源捉取图像
CatchImage(#imgScreen1, ?_ICON_PureBasic)

;2.从程序的内存中捉取图像
FileName$ = ".\PureBasic.ico"
FileSize = FileSize(FileName$)
*MemData = AllocateMemory(FileSize)
FileID = ReadFile(#PB_Any, FileName$) 
If FileID
   ReadData(FileID, *MemData, FileSize)
   CloseFile(FileID)
EndIf 

CatchImage(#imgScreen2, *MemData)


If OpenWindow(#winScreen, 0, 0, 400, 200, "CatchImage_提取图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   SetWindowColor(#winScreen, $CFFFFF)
   ImageGadget(#picScreen1, 040, 050, 100, 100, ImageID(#imgScreen1))
   ImageGadget(#picScreen2, 150, 050, 100, 100, ImageID(#imgScreen2))
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen1)  ;注销图像
FreeImage(#imgScreen2)
End

;- ##########################
;- [Data]
DataSection
_ICON_PureBasic:
   IncludeBinary ".\PureBasic.ico" 
EndDataSection


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP