;***********************************
;迷路仟整理 2019.02.11
;矢量几何_绘制多边形
;***********************************

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Procedure Draw_Polygon(X, Y, W, H, Edges, Angle.f)

   RadiusX = (W / 2)       ;半径
   RadiusY = (H / 2)
   CenterX = X + RadiusX   ;中心坐标
   CenterY = Y + RadiusY
   
   AddPathEllipse(CenterX, CenterY, RadiusX, RadiusY)
   VectorSourceColor($44ff0088)
   StrokePath(0.0000001)

   For i = 0 To Edges
      iAngle.f = Radian(i * 360.0 / Edges) + Radian(Angle)
      x = CenterX - RadiusX * Cos(iAngle)
      y = CenterY - RadiusY * Sin(iAngle)
      If i = 0
         MovePathCursor(x, y)
      Else 
         AddPathLine(x, y)
      EndIf
   Next
   VectorSourceColor($ff0000ff)
   StrokePath(2)
EndProcedure

Procedure Window_RadowingScreen()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      Angle.f = 90  ;旋转角度
      Draw_Polygon(030, 030, 100, 100, 03, Angle)
      Draw_Polygon(150, 030, 100, 100, 04, Angle)
      Draw_Polygon(270, 030, 100, 100, 05, Angle)
      Draw_Polygon(030, 150, 100, 100, 06, Angle)
      Draw_Polygon(150, 150, 100, 100, 08, Angle)
      Draw_Polygon(270, 150, 100, 100, 12, Angle)
      StopVectorDrawing()
   EndIf
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 280, "矢量几何_绘制多边形", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, 400, 280)
Window_RadowingScreen()
Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 53
; Folding = 6
; EnableXP
; EnableUnicode