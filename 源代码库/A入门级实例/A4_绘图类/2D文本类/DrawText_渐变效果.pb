;***********************************
;迷路仟整理 2019.01.22
;DrawText_渐变效果
;***********************************

#winScreen = 0
#picScreen = 0
#fntScreen = 0

hFont = LoadFont(#fntScreen, "宋体", 64, #PB_Font_Bold)

ImageID = CreateImage(#PB_Any, 500, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingFont(hFont)
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_Transparent)  
      BackColor($0000FF)            ;前景色
      GradientColor(0.3, $00FFFF)   ;渐变插值
      GradientColor(0.7, $FFFF00)   ;渐变插值
      FrontColor($FF0000)           ;背景色
      CircularGradient(200, 100, 200)  
      DrawText(50+0, 50+0, "PureBasic", FontColor)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 200, "DrawText_渐变效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 9
; EnableXP