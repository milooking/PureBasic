;***********************************
;迷路仟整理 2019.01.23
;FillArea_填充效果
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 300, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      Circle  (200, 150, 125 ,$00FF00)       ;绘制外圆
      Circle  (200, 150, 120 ,$FF0000)       ;绘制内圆
      LineXY  (80, 150, 320, 150, $FFFFFF)   ;绘制分切线
      FillArea(200, 155, -1, $0000FF)        ;填充内圆下半部分,坐标(200,155)是内圆下半部分内的一点
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 300, "FillArea_填充效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP