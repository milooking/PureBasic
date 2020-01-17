;***********************************
;迷路仟整理 2019.01.23
;Point_获取点的颜色
;***********************************

#winScreen = 0
#picScreen = 0



ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
  
      DrawingMode(#PB_2DDrawing_Gradient)      
      BackColor($0000FF)
      GradientColor(0.4, $00FFFF)
      GradientColor(0.6, $FFFF00)
      FrontColor($FF0000)
      LinearGradient(0, 0, 400, 0)  
      Box(000,000,400,200)
      
      Color = Point(100,100)
      Debug "R = " + Red(Color)
      Debug "G = " + Green(Color)
      Debug "B = " + Blue(Color)
      Debug "Color = 0x" + Hex(RGB(Red(Color), Green(Color), Blue(Color)))
      Debug "Color = 0x" + Hex(Color)
      ;注意,PureBasic的颜色系统与PS的颜色体系是相反的,
      ; PureBasic是ABGR,低位是R, PS是ARGB, 低位是B
      ; 如: $0000FF在PureBasic中是正红色,在PS中是正蓝色
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "Point_获取点的颜色", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; FirstLine = 10
; EnableXP