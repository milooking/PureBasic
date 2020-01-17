;***********************************
;迷路仟整理 2019.02.07
;VectorImage_图像蒙版
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0


Procedure Vector_Drawing()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceImage(hImage, 255, ImageWidth(#imgScreen), ImageHeight(#imgScreen), #PB_VectorImage_Repeat)
      AddPathCircle(200, 125, 75)
      FillPath()                      
      StopVectorDrawing()
   EndIf 
EndProcedure

hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 0, 0, 400, 250, "VectorImage_图像蒙版", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   Vector_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; Folding = -
; EnableXP