;***********************************
;迷路仟整理 2019.01.23
;DrawText_背景填充效果
;***********************************

#winScreen = 0
#picScreen = 0
#fntScreen = 0
#imgScreen = 0

hImage = LoadImage(#imgScreen, "..\Background.bmp")
hFont = LoadFont(#fntScreen, "宋体", 64, #PB_Font_Bold)

ImageID = CreateImage(#PB_Any, 500, 200, 32, 0)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_AllChannels) 
      Box(000, 000, 500, 200, $00000000) 
      DrawingFont(hFont)
      DrawingMode(#PB_2DDrawing_AlphaBlend)  
      DrawText(50+0, 50+0, "PureBasic", $FF000000, $00000000)
      DrawingMode(#PB_2DDrawing_AlphaClip)  
      DrawImage(hImage, 0, 0, 500, 250)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 200, "DrawText_背景填充效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP