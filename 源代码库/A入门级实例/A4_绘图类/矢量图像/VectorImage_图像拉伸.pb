;***********************************
;迷路仟整理 2019.02.12
;VectorImage_图像拉伸
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0

;方法1:填充+绘制拉伸
Procedure Vector_Drawing1()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceImage(hImage, 255, GadgetWidth(#cvsScreen), GadgetHeight(#cvsScreen))
      FillVectorOutput()
      StopVectorDrawing()
   EndIf 
EndProcedure

;方法2:径路+绘制拉伸
Procedure Vector_Drawing2()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceImage(hImage, 255, GadgetWidth(#cvsScreen), GadgetHeight(#cvsScreen), #PB_VectorImage_Repeat)
      AddPathBox(000, 000, 600, 350)
      FillPath()
      StopVectorDrawing()
   EndIf 
EndProcedure

;方法3:绘制拉伸
Procedure Vector_Drawing3()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      DrawVectorImage(hImage, 255, GadgetWidth(#cvsScreen), GadgetHeight(#cvsScreen))
      StopVectorDrawing()
   EndIf 
EndProcedure

;方法4:比例坐标法
Procedure Vector_Drawing4()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      ScaleCoordinates(GadgetWidth(#cvsScreen)/ImageWidth(#imgScreen), GadgetHeight(#cvsScreen)/ImageHeight(#imgScreen))
      DrawVectorImage(hImage, 255)
      StopVectorDrawing()
   EndIf 
EndProcedure


hImage = LoadImage(#imgScreen, "..\PureBasic.bmp")

If OpenWindow(#winScreen, 0, 0, 600, 350, "VectorImage_图像拉伸", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 350)
;    Vector_Drawing1()
;    Vector_Drawing2()
;    Vector_Drawing3()
   Vector_Drawing4()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 49
; FirstLine = 24
; Folding = -
; EnableXP