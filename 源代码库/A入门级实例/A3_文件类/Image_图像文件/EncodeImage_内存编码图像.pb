;***********************************
;迷路仟整理 2019.01.23
;EncodeImage_内存编码图像
;***********************************

UsePNGImageEncoder()

Enumeration
   #winScreen
   #imgScreen
   #picScreen

EndEnumeration


hWindow = OpenWindow(#winScreen, 0, 0, 400, 200, "EncodeImage_内存编码图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
  hImage = LoadImage(#imgScreen, "Background.bmp")
  ImageGadget(#picScreen, 0, 0, 400, 200, hImage, #PB_Image_Border)
  ;在对BMP图像进行PNG编码,并返回编码后的内存指针
  *pMemImage = EncodeImage(#imgScreen, #PB_ImagePlugin_PNG)
  ShowMemoryViewer(*pMemImage, MemorySize(*pMemImage))
  
Repeat
   WinEvent = WaitWindowEvent() 
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu

   EndSelect    
Until IsExitWindow = #True

FreeImage(#imgScreen)   ;注销图像
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP