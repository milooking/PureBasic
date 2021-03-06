﻿;***********************************
;迷路仟整理 2019.01.22
;Plot_绘制像素点
;***********************************

#winScreen = 0
#picScreen = 0

;注: Plot()有检测是否在绘制域内,超去会报错, Box()没有检测绘制域内,
;    因此,在很多场景下,可以用Box(x,y,1,1)来替代Plot()
ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      For x = 0 To 399
        For y = 0 To 199
          Plot(x, y, RGB(Random(255), Random(255), Random(255)))
        Next
      Next 
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "Plot_绘制像素点", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; EnableXP