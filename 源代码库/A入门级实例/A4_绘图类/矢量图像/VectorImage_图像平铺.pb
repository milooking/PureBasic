;***********************************
;迷路仟整理 2019.02.12
;VectorImage_图像平铺
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0

;方法1
Procedure Vector_Drawing1()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceImage(hImage, 255, ImageWidth(#imgScreen), ImageHeight(#imgScreen), #PB_VectorImage_Repeat)
      FillVectorOutput()
      StopVectorDrawing()
   EndIf 
EndProcedure

;方法2
Procedure Vector_Drawing2()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceImage(hImage, 255, ImageWidth(#imgScreen), ImageHeight(#imgScreen), #PB_VectorImage_Repeat)
      AddPathBox(000, 000, 600, 350)
      FillPath()
      StopVectorDrawing()
   EndIf 
EndProcedure



hImage = LoadImage(#imgScreen, "..\PureBasic.bmp")

If OpenWindow(#winScreen, 0, 0, 600, 350, "VectorImage_图像平铺", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 350)
   Vector_Drawing1()
;    Vector_Drawing2()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; FirstLine = 4
; Folding = -
; EnableXP