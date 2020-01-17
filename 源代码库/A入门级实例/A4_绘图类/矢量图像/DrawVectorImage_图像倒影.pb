;***********************************
;迷路仟整理 2019.02.11
;DrawVectorImage_图像倒影
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0


Procedure Vector_Drawing()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(050, 000)
      DrawVectorImage(hImage, 255)
      FlipCoordinatesY(215)
      MovePathCursor(050, 000)
      DrawVectorImage(hImage, 64, ImageWidth(#imgScreen), ImageHeight(#imgScreen)/2)
      StopVectorDrawing()
   EndIf 
EndProcedure


UsePNGImageDecoder()
hImage = LoadImage(#imgScreen, "..\Apple.png")

If OpenWindow(#winScreen, 0, 0, 400, 500, "DrawVectorImage_图像倒影", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 500)
   Vector_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; Folding = -
; EnableXP