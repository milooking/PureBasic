;***********************************
;迷路仟整理 2019.01.22
;DrawImage_图像蒙版
;***********************************

#winScreen = 0
#picScreen = 0
#imgScreen = 0


hImage = LoadImage(#imgScreen, "..\Background.bmp")
ImageID = CreateImage(#PB_Any, 400, 200, 32)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(000, 000, 400, 200, $20FFFFFF)   ;<<----------
;       Box(000, 000, 400, 200, $00FFFFFF)   ;<<----------
      Circle(200, 100, 080, $FF000000)      
      DrawingMode(#PB_2DDrawing_AlphaClip)
      DrawImage(hImage, 0, 0)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "DrawImage_图像蒙版", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; EnableXP