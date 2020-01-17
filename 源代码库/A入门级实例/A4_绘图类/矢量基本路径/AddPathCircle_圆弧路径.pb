;***********************************
;迷路仟整理 2019.01.24
;AddPathCircle_圆弧路径
;***********************************

#winScreen = 0
#cvsScreen = 0

;AddPathCircle_圆弧路径的原理是这样的:
;将上一路径的结束点视为(x0,y0), 通过AddPathArc()中,(x1,y1), (x2,y2)这两个点,
;形成一个以(x0,y0)-(x1,y1)和(x2,y2)-(x1,y1)为边,以(x1,y1)为夹角顶点的角.
;在夹角处进行圆角处理,形成弧线.

If OpenWindow(#winScreen, 0, 0, 600, 350, "AddPathCircle_圆弧路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 350)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      AddPathCircle (100, 100, 075, 000, 235)   ;画一段圆弧
  
      MovePathCursor(300, 100)                  ;移动路径起始点,起断点作用,将上一路径与这个路径进行断开隔离
      AddPathCircle (300, 100, 075, 000, 235)   ;画一段圆弧
      ClosePath()                               ;封闭效果

      MovePathCursor(500, 100)                  ;移动路径起始点,起断点作用,将上一路径与这个路径进行断开隔离
      AddPathCircle (500, 100, 075, 000, 235, #PB_Path_Connected) ;连线效果,起扇形效果作用
      ClosePath()
      
      VectorSourceColor(RGBA(255, 0, 0, 255))   ;定义路径颜色
      StrokePath(5)                             ;定义路径大小,并呈现
      
      MovePathCursor(100, 300)                  ;移动路径起始点,起断点作用,将上一路径与这个路径进行断开隔离
      AddPathCircle (100, 300, 75, 0, 235, #PB_Path_CounterClockwise) ;顺时针效果
    
      
      MovePathCursor(300, 300)                  ;移动路径起始点,起断点作用,将上一路径与这个路径进行断开隔离
      AddPathCircle (300, 300, 75, 0, 235, #PB_Path_CounterClockwise) ;顺时针效果
      ClosePath()

      MovePathCursor(500, 300)                  ;移动路径起始点,起断点作用,将上一路径与这个路径进行断开隔离
      AddPathCircle (500, 300, 75, 0, 235, #PB_Path_CounterClockwise|#PB_Path_Connected) ;顺时针效果加连线效果
      ClosePath()

      VectorSourceColor(RGBA(255, 0, 128, 255)) ;定义路径颜色
      StrokePath(5)                             ;定义路径大小,并呈现
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP