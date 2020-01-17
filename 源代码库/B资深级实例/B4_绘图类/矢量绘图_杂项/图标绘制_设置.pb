;***********************************
;迷路仟整理 2019.03.13
;图标绘制_设置1
;***********************************

#winScreen = 0
#cvsScreen = 0


Procedure$ VectorStyle1()
   X.d : Y.d 
   InsideR.d = 080    : OutsideR.d = 120
   CenterX.d = 128    : CenterY.d  = 128 
   Angle.d = -90+45/2 : RotateArc  = 14
   Radian.d = Radian(Angle-RotateArc)
   x = CenterX + OutsideR * Cos(Radian)
   y = CenterY + OutsideR * Sin(Radian)
   MovePathCursor(x, y)
   For k = 1 To 8
      AddPathCircle (CenterX, CenterY, InsideR, Angle-RotateArc, Angle+RotateArc, #PB_Path_Connected)
      Radian.d = Radian(Angle+RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
      Angle+45      
      Radian.d = Radian(Angle-RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
   Next 
   ClosePath()
   AddPathCircle (CenterX, CenterY, 40)  
   Segments$ = PathSegments()
   ProcedureReturn Segments$ 
EndProcedure

Procedure$ VectorStyle2()
   X.d : Y.d 
   InsideR.d = 080    : OutsideR.d = 120 
   CenterX.d = 128    : CenterY.d  = 128 
   Angle.d = -90+45/2 : RotateArc  = 15
   Radian.d = Radian(Angle-RotateArc)
   x = CenterX + OutsideR * Cos(Radian)
   y = CenterY + OutsideR * Sin(Radian)
   MovePathCursor(x, y)
   For k = 1 To 8
      AddPathCircle (CenterX, CenterY, InsideR, Angle-RotateArc+3, Angle+RotateArc-3, #PB_Path_Connected)
      Radian.d = Radian(Angle+RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
      Angle+45      
      Radian.d = Radian(Angle-RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
   Next 
   ClosePath()
   AddPathCircle (CenterX, CenterY, 40)   
   Segments$ = PathSegments()
   ProcedureReturn Segments$ 
EndProcedure

Procedure$ VectorStyle3()
   X.d : Y.d 
   InsideR.d = 080    : OutsideR.d = 120 
   CenterX.d = 128    : CenterY.d  = 128 
   Angle.d = -90+45/2 : RotateArc  = 17
   Radian.d = Radian(Angle-RotateArc)
   x = CenterX + OutsideR * Cos(Radian)
   y = CenterY + OutsideR * Sin(Radian)
   MovePathCursor(x, y)
   For k = 1 To 8
      AddPathCircle (CenterX, CenterY, InsideR, Angle-RotateArc+10, Angle+RotateArc-10, #PB_Path_Connected)
      Radian.d = Radian(Angle+RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
      Angle+45      
      Radian.d = Radian(Angle-RotateArc)
      x = CenterX + OutsideR * Cos(Radian)
      y = CenterY + OutsideR * Sin(Radian)
      AddPathLine(X, Y)
   Next 
   ClosePath()
   AddPathCircle (CenterX, CenterY, 40)  
   Segments$ = PathSegments()
   ProcedureReturn Segments$ 
EndProcedure

If OpenWindow(#winScreen, 0, 0, 256*3, 512, "图标绘制_设置1", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 256*3, 512)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FF383838)
      FillVectorOutput()

      Sale.d = 48/256
;       ScaleCoordinates(Sale, Sale)         ;缩放比例
      ;======================================
      VectorSourceColor($FFFFFF00) 
      Segments$ = VectorStyle1()
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条
      
      TranslateCoordinates(0000, 0256)
      AddPathSegments(Segments$)
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条      
      AddPathSegments(Segments$)
      FillPath()                             ;填充域
      ;======================================
      VectorSourceColor($FFFF00FF) 
      TranslateCoordinates(0256, -256)
      Segments$ = VectorStyle2()
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条
      
      TranslateCoordinates(0000, 0256)
      AddPathSegments(Segments$)
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条      
      AddPathSegments(Segments$)
      FillPath()                             ;填充域
      ;======================================
      VectorSourceColor($FF00FFFF)       
      TranslateCoordinates(0256, -256)
      Segments$ = VectorStyle3()
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条
      
      TranslateCoordinates(0000, 0256)
      AddPathSegments(Segments$)
      StrokePath(10, #PB_Path_RoundCorner)   ;绘制线条
      AddPathSegments(Segments$)
      FillPath()                             ;填充域
      ;======================================
      StopVectorDrawing()              
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 

End





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 130
; FirstLine = 24
; Folding = 5
; EnableXP