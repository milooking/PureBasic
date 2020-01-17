;***********************************
;迷路仟整理 2019.01.24
;DrawVectorImage_绘制矢量图片
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0


hImage = LoadImage(#imgScreen, #PB_Compiler_Home + "examples/Sources/Data/PureBasicLogo.bmp")

If OpenWindow(#winScreen, 0, 0, 500, 300, "DrawVectorImage_绘制矢量图片", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 300)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(50, 50)
      ;绘制图像,透明度127即0.5+-
      DrawVectorImage(hImage, 127)     
      
      MovePathCursor(75, 75)           
      ;绘制图像,并进行宽度的缩放
      DrawVectorImage(hImage, 127, ImageWidth(#imgScreen)/2, ImageHeight(#imgScreen))

      MovePathCursor(120, 0)
      ;绘制图像,35度旋转
      RotateCoordinates(120, 0, 35)
      DrawVectorImage(hImage, 64)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP