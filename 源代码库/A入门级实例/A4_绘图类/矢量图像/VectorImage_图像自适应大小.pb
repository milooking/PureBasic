;***********************************
;迷路仟整理 2019.02.12
;VectorImage_图像自适应大小
;***********************************

Enumeration
   #winScreen
   #cvsScreen1
   #cvsScreen2
   #imgScreen
EndEnumeration


Procedure Vector_Drawing()
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen1))
      FrameW = GadgetWidth (#cvsScreen1)
      FrameH = GadgetHeight(#cvsScreen1)
      ImageW = ImageWidth (#imgScreen)
      ImageH = ImageHeight(#imgScreen)
      ;判断宽高比例系数
      SaleW.f = ImageW/FrameW
      SaleH.f = ImageH/FrameH
      ;获得自适应比例系数
      If SaleW >= SaleH : Sale.f = SaleH : Else : Sale.f = SaleW : EndIf 
      ;重新计算图像大小及绘制位置
      ZoomW = ImageW / Sale
      ZoomH = ImageH / Sale
      ZoomX = (FrameW-ZoomW)/2
      ZoomY = (FrameH-ZoomH)/2
      MovePathCursor(ZoomX, ZoomY)
      DrawVectorImage(hImage, 255, ZoomW, ZoomH)
      StopVectorDrawing()
   EndIf    

   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen2))
      FrameW = GadgetWidth (#cvsScreen2)
      FrameH = GadgetHeight(#cvsScreen2)
      ImageW = ImageWidth (#imgScreen)
      ImageH = ImageHeight(#imgScreen)
      ;判断宽高比例系数
      SaleW.f = ImageW/FrameW
      SaleH.f = ImageH/FrameH
      ;获得自适应比例系数
      If SaleW >= SaleH : Sale.f = SaleH : Else : Sale.f = SaleW : EndIf 
      ;重新计算图像大小及绘制位置
      ZoomW = ImageW / Sale
      ZoomH = ImageH / Sale
      ZoomX = (FrameW-ZoomW)/2
      ZoomY = (FrameH-ZoomH)/2
      MovePathCursor(ZoomX, ZoomY)
      DrawVectorImage(hImage, 255, ZoomW, ZoomH)
      StopVectorDrawing()
   EndIf    
EndProcedure



hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 0, 0, 600, 350, "VectorImage_图像自适应大小", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen1, 010, 010, 200, 300, #PB_Canvas_Border)
   CanvasGadget(#cvsScreen2, 220, 070, 350, 150, #PB_Canvas_Border)
   Vector_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 63
; FirstLine = 30
; Folding = -
; EnableXP