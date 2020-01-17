;***********************************
;迷路仟整理 2019.02.15
;DrawImage_图像水印
;***********************************

Enumeration
   #winScreen
   #picScreen
   #imgScreen
   #fntScreen
EndEnumeration


hFont  = LoadFont(#fntScreen, "", 16)
hImage = LoadImage(#imgScreen, "..\Background.bmp")
ImageID = CreateImage(#PB_Any, 400, 200, 32)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      DrawImage(hImage, 0, 0)
      DrawingFont(hFont)
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      
      For R = 10 To 400 Step 60
         For C = 10 To 400 Step 120
            DrawRotatedText(C, R, "PureBasic", 30, RGBA(128,128,128,100))
         Next
      Next
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "DrawImage_图像水印", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP