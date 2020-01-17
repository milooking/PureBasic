;***********************************
;迷路仟整理 2019.01.22
;DrawText_投影效果
;***********************************

#winScreen = 0
#picScreen = 0
#fntScreen = 0

hFont = LoadFont(#fntScreen, "宋体", 64, #PB_Font_Bold)

ImageID = CreateImage(#PB_Any, 500, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingFont(hFont)
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawText(55, 55, "PureBasic", $808080)
      DrawText(50, 50, "PureBasic", $0080FF)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 200, "DrawText_投影效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; EnableXP