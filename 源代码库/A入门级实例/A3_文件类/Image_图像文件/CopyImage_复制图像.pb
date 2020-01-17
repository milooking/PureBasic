;***********************************
;迷路仟整理 2019.01.23
;CopyImage_复制图像
;***********************************

Enumeration
   #winScreen
   #imgScreen1
   #imgScreen2
   #picScreen1
   #picScreen2
   #picScreen3
EndEnumeration

CatchImage(#imgScreen1, ?_ICON_PureBasic)

;将#imgScreen1复制到#imgScreen2
CopyImage(#imgScreen1, #imgScreen2)   

;将#imgScreen1复制到一个随机编号的图像,并返回这个图像的编号
ImageID = CopyImage(#imgScreen1, #PB_Any)   


If OpenWindow(#winScreen, 0, 0, 400, 200, "CopyImage_复制图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   SetWindowColor(#winScreen, $CFFFFF)
   ImageGadget(#picScreen1, 040, 050, 100, 100, ImageID(#imgScreen1))
   ImageGadget(#picScreen2, 150, 050, 100, 100, ImageID(#imgScreen2))
   ImageGadget(#picScreen3, 260, 050, 100, 100, ImageID(ImageID))
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen1)  ;注销图像
FreeImage(#imgScreen2)
FreeImage(ImageID)
End

;- ##########################
;- [Data]
DataSection
_ICON_PureBasic:
   IncludeBinary ".\PureBasic.ico" 
EndDataSection


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = -
; EnableXP