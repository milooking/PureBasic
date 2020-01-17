;***********************************
;迷路仟整理 2019.01.24
;AddPathEllipse_椭圆形路径
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathEllipse_椭圆形路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      AddPathEllipse(100, 100, 080, 030)        ;添加一个椭圆形路径
      
      SaveVectorState()                         ;记录当前矢量绘图的状态,起切换到另一矢量绘图空间的作用
        RotateCoordinates(300, 100, 045)        ;旋转新空间画板,旋转椭圆形的作用
        AddPathEllipse(300, 100, 080, 030)      ;添加一个椭圆形路径
      RestoreVectorState()                      ;恢复矢量绘图的状态
      
      VectorSourceColor(RGBA(255, 0, 0, 255))   ;定义路径颜色
      StrokePath(5)                             ;定义路径大小,并呈现
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP