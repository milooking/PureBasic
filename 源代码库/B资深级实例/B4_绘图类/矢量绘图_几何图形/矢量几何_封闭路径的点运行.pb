;***********************************
;迷路仟整理 2019.02.19
;矢量几何_封闭路径的点运行
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #tmrScreen
EndEnumeration


Global _Distance.f

Procedure Redraw_SpecialEffect()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      
      ;创建一个路径
      MovePathCursor(110, 54)
      AddPathLine(55, 105)
      AddPathCurve(200, 120, -60, 230, 190, 222)
      AddPathCircle(150, 145, 99, 46, -115, #PB_Path_Connected | #PB_Path_CounterClockwise)
      
      Length.f = PathLength()
      _Distance  + 1.0
      If _Distance > Length : _Distance = 0 : EndIf 
      
      ; 在路径上获取一个指定位置和角度的点
      x = PathPointX(_Distance)
      y = PathPointY(_Distance)
      a = PathPointAngle(_Distance)
      VectorSourceColor($FF0000FF)
      Segments$ = PathSegments()       ;记录这种路径
      StrokePath(11)
      
      ;在相同路径上覆盖上宽度更小的白色
      AddPathSegments(Segments$)                   
      VectorSourceColor(RGBA(255, 255, 255, 255))  
      StrokePath(5)   
      
      ; 标识出这个点来
      AddPathCircle(x, y, 11)
      VectorSourceColor($FFFF0000)
      FillPath()
      MovePathCursor(x, y)
      AddPathLine(20 * Cos(Radian(a)), 20 * Sin(Radian(a)), #PB_Path_Relative)
      StrokePath(9)      
      
      ; 标识出这个点来
      AddPathCircle(x, y, 07)
      VectorSourceColor($FFFFFFFF)
      FillPath()    
      MovePathCursor(x, y)
      AddPathLine(15 * Cos(Radian(a)), 15 * Sin(Radian(a)), #PB_Path_Relative)
      StrokePath(3)           

      StopVectorDrawing()
   EndIf 

EndProcedure


If OpenWindow(#winScreen, 0, 0, 300, 250, "矢量几何_封闭路径的点运行", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 300, 250)
   Redraw_SpecialEffect()
   
   AddWindowTimer(#winScreen, #tmrScreen, 10)
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer       : Redraw_SpecialEffect()
      EndSelect
   Until IsExitWindow = #True 
EndIf 
End











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; FirstLine = 6
; Folding = -
; EnableXP