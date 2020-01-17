;***********************************
;迷路仟整理 2019.02.06
;平面绘图_绘制多边形
;***********************************

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Procedure Draw_Polygon(X, Y, W, H, Edges, Angle.f)
   DrawingMode(#PB_2DDrawing_AlphaBlend | #PB_2DDrawing_Outlined)
   Box(X, Y, W, H, $22ff0088)
   RadiusX = (W / 2)       ;半径
   RadiusY = (H / 2)
   CenterX = X + RadiusX   ;中心坐标
   CenterY = Y + RadiusY
   
   Ellipse(CenterX, CenterY, RadiusX, RadiusY, $66ff0088)
   
   For i = 0 To Edges
      iAngle.f = Radian(i * 360.0 / Edges) + Radian(Angle)
      x1 = CenterX - RadiusX * Cos(iAngle)
      y1 = CenterY - RadiusY * Sin(iAngle)
      If i > 0
         LineXY(x1, y1, x2, y2, $ff0000ff)
      EndIf
      x2 = x1
      y2 = y1
   Next
EndProcedure

Procedure Window_RedrawingScreen()
   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(0, 0, 400, 280, $FFFFFFFF)
      Angle.f = 90  ;旋转角度
      Draw_Polygon(030, 030, 100, 100, 03, Angle)
      Draw_Polygon(150, 030, 100, 100, 04, Angle)
      Draw_Polygon(270, 030, 100, 100, 05, Angle)
      Draw_Polygon(030, 150, 100, 100, 06, Angle)
      Draw_Polygon(150, 150, 100, 100, 08, Angle)
      Draw_Polygon(270, 150, 100, 100, 12, Angle)
      StopDrawing()
   EndIf
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 280, "平面绘图_绘制多边形", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, 400, 280)
Window_RedrawingScreen()
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
; CursorPosition = 52
; FirstLine = 24
; Folding = -
; EnableXP
; EnableUnicode