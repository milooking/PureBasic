;***********************************
;迷路仟整理 2019.01.22
;CircularGradient_圆形渐变效果
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_Gradient)    ;启用渐变模形式     
      BackColor ($00FFFF)                    ;设置背景色
      FrontColor($0000FF)                    ;设置前景色
      
      CircularGradient(050, 050, 150)        ;设置渐变区域 
      Box(050, 050, 100, 100)                ;绘制需要渐变的图形
      
      CircularGradient(300, 100, 100)        ;设置渐变区域 
      Circle(300, 100, 100, $FF0000)         ;绘制需要渐变的图形(注意此处$FF0000颜色值不起作用)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "CircularGradient_圆形渐变效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP