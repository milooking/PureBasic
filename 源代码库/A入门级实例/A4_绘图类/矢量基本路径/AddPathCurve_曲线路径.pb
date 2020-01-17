;***********************************
;迷路仟整理 2019.01.24
;AddPathCurve_曲线路径
;***********************************

#winScreen = 0
#cvsScreen = 0

;AddPathCurve_贝塞尔曲线原理:
;将上一路径的结束点视为(x0,y0), 通过AddPathCurve()中,(x1,y1), (x2,y2), (x3,y3)这三个点,共四个点,
;由上述四个点,形成一条三阶的贝塞尔曲线

If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathCurve_曲线路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(50, 100)                      ;设置路径起始点
      AddPathCurve(090, 030, 250, 180, 350, 100)   ;添加一条贝塞尔曲线路径
      VectorSourceColor(RGBA(255, 0, 000, 255))    ;定义路径颜色
      StrokePath(5)                                ;定义路径大小,并呈现
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; FirstLine = 1
; EnableXP