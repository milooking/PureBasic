;***********************************
;迷路仟整理 2019.01.23
;GrabImage_裁剪图像
;***********************************

Enumeration
   #winScreen
   #imgScreen1
   #imgScreen2
   #picScreen1
   #picScreen2
EndEnumeration

LoadImage(#imgScreen1, "Background.bmp")

;从#imgScreen1裁剪得到#imgScreen2
GrabImage(#imgScreen1, #imgScreen2, 050, 100, 100, 100)   

;从#imgScreen1裁剪得到一个随机编号的图像,并返回这个图像的编号
ImageID = GrabImage(#imgScreen1, #PB_Any, 150, 100, 100, 100)   


If OpenWindow(#winScreen, 0, 0, 400, 200, "GrabImage_裁剪图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   SetWindowColor(#winScreen, $CFFFFF)
   ImageGadget(#picScreen1, 100, 050, 100, 100, ImageID(#imgScreen2))
   ImageGadget(#picScreen2, 205, 050, 100, 100, ImageID(ImageID))
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen1)  ;注销图像
FreeImage(#imgScreen2)
FreeImage(ImageID)
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP