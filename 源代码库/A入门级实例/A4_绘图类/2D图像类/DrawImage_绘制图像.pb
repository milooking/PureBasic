;***********************************
;迷路仟整理 2019.01.22
;DrawImage_绘制图像
;***********************************

#winScreen = 0
#picScreen = 0
#imgScreen = 0

UsePNGImageDecoder()  ;如果使用非BMP或ICO图像,就得启用相对应类型的图像解码器

hImage = LoadImage(#imgScreen, #PB_Compiler_Home + "examples/Sources/Data/PureBasicLogo.bmp")
ImageID = CreateImage(#PB_Any, 800, 400, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_Transparent)
      For i = 1 To 5
         DrawImage(hImage, Random(400), Random(400))
      Next
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 800, 400, "DrawImage_绘制图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; EnableXP