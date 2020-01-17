;***********************************
;迷路仟整理 2019.01.22
;GradientColor_渐变色插值
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_Gradient)      
      BackColor($0000FF)            ;前景色
      GradientColor(0.3, $00FFFF)   ;渐变插值
      GradientColor(0.7, $FFFF00)   ;渐变插值
      FrontColor($FF0000)           ;背景色
      
      LinearGradient(0, 0, 200, 200)    
      Circle(100, 100, 100) 
        
      LinearGradient(350, 100, 250, 100)
      Circle(300, 100, 100)

      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "GradientColor_渐变色插值", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; FirstLine = 11
; EnableXP