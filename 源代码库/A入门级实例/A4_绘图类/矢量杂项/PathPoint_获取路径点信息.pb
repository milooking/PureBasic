;***********************************
;迷路仟整理 2019.01.24
;PathPoint_获取路径点信息
;***********************************

;PathPointX()
;PathPointY()
;PathPointAngle()


#winScreen = 0
#cvsScreen = 0


If OpenWindow(#winScreen, 0, 0, 400, 250, "PathPoint_获取路径点信息", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

      ;创建一个路径
      MovePathCursor(150, 125)
      AddPathCurve(0, 270, 0, -150, 350, 180)
      
      ; 在路径上获取一个指定位置和角度的点
      x = PathPointX(200)
      y = PathPointY(200)
      a = PathPointAngle(200)
      
      VectorSourceColor($FF0000FF)
      StrokePath(5)
      
      ; 标识出这个点来
      AddPathCircle(x, y, 10)
      VectorSourceColor($FFFF0000)
      FillPath()
      
      MovePathCursor(x, y)
      AddPathLine(80*Cos(Radian(a)), 80*Sin(Radian(a)), #PB_Path_Relative)
      StrokePath(5)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP