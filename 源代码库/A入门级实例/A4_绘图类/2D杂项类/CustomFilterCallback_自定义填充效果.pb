;***********************************
;迷路仟整理 2019.01.23
;CustomFilterCallback_自定义填充效果
;***********************************

#winScreen = 0
#picScreen = 0

Procedure Filter_Callback(x, y, SourceColor, TargetColor)
    ProcedureReturn RGBA(Red(SourceColor), Green(TargetColor), Blue(TargetColor), Alpha(TargetColor))
EndProcedure


hImage = LoadImage(#picScreen, "..\Background.bmp")

ImageID = CreateImage(#PB_Any, 400, 250, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawImage(hImage, 0, 0, 400, 250)
      DrawingMode(#PB_2DDrawing_CustomFilter)      
      CustomFilterCallback(@Filter_Callback())
      Circle(100, 125, 100, $0000FF)   
      Circle(300, 125, 100, $000000)
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 250, "CustomFilterCallback_自定义填充效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; Folding = -
; EnableXP