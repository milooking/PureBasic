;***********************************
;迷路仟整理 2019.01.15
;ImageOutput_图像2D绘图
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      Line  (025,025,350,1, $FF8000)                  ;画直线
      Box   (050,050,050,050, $0000E0)                ;矩形
      Circle(175,075,025, $D00000)                    ;画圆
      RoundBox(250, 050, 100, 050, 15, 15, $008000)   ;圆角形 
      Ellipse(100, 150, 050, 025, $FF00FF)            ;椭圆形 
      
      DrawingMode(#PB_2DDrawing_Gradient)             ;渐变风格
      BackColor ($00FFFF)
      FrontColor($0000FF)
      LinearGradient(250, 125, 350, 125)    
      Box(250, 125, 100, 050)   
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "ImageOutput_图像2D绘图", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 31
; FirstLine = 10
; EnableXP