;***********************************
;迷路仟整理 2019.02.08
;DrawImage_马赛克效果
;***********************************

#winScreen = 0
#picScreen = 0
#imgScreen = 0

UsePNGImageDecoder()  ;如果使用非BMP或ICO图像,就得启用相对应类型的图像解码器


Value = 5
hImage = LoadImage(#imgScreen, "..\Background.bmp")
If hImage
   ImageW = ImageWidth(#imgScreen)
   ImageH = ImageHeight(#imgScreen)
   If ResizeImage(#imgScreen, ImageW / Value , ImageH / Value)
      ResizeImage(#imgScreen, ImageW, ImageH, #PB_Image_Raw)      ;<-- #PB_Image_Raw最值
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "DrawImage_马赛克效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP