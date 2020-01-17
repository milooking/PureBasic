;***********************************
;迷路仟整理 2019.01.23
;ClipOutput_设置绘制域
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 300, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      ClipOutput(50, 50, 100, 100)     ;所有绘制的区域只能坐标为(50,50)面积为100x100的区域
      Circle( 50,  50, 50, $0000FF)  
      Circle( 50, 150, 50, $00FF00)  
      Circle(150,  50, 50, $FF0000)  
      Circle(150, 150, 50, $00FFFF)  
      
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(50, 50, 100, 100, $000000)
      UnclipOutput()                   ;取消绘制区域限制
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 300, "ClipOutput_设置绘制域", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 6
; EnableXP