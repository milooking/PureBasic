;***********************************
;迷路仟整理 2019.01.22
;DrawText_镂空效果
;***********************************

#winScreen = 0
#picScreen = 0
#fntScreen = 0

hFont = LoadFont(#fntScreen, "宋体", 64, #PB_Font_Bold)

ImageID = CreateImage(#PB_Any, 500, 200, 32)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_AllChannels) 
      Box(000, 000, 500, 200, $00000000) 
      DrawingFont(hFont)
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      LineColor = $FF0080FF      ;描边颜色
      i = 2                      ;描边大小
      DrawText(50-i, 50-i, "PureBasic", LineColor, $0000000) ;上左
      DrawText(50+0, 50-i, "PureBasic", LineColor, $0000000) ;上中
      DrawText(50+i, 50-i, "PureBasic", LineColor, $0000000) ;上右
      DrawText(50-i, 50+i, "PureBasic", LineColor, $0000000) ;下左
      DrawText(50+0, 50+i, "PureBasic", LineColor, $0000000) ;下中
      DrawText(50+i, 50+i, "PureBasic", LineColor, $0000000) ;下右
      DrawText(50-i, 50+0, "PureBasic", LineColor, $0000000) ;中左
      DrawText(50+i, 50+0, "PureBasic", LineColor, $0000000) ;中右
      DrawingMode(#PB_2DDrawing_AlphaChannel|#PB_2DDrawing_Transparent)
      DrawText(50+0, 50+0, "PureBasic", $0000000, $0000000)

      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 200, "DrawText_镂空效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; FirstLine = 18
; EnableXP