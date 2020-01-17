;***********************************
;迷路仟整理 2019.01.24
;AddPathSegments_节点路径
;***********************************

#winScreen = 0
#cvsScreen = 0

; 通过字符串描述,绘制一个路径,用于记录和保存路径,也起来脚本作用
; M x y                MovePathCursor()
; L x y                AddPathLine()
; C x1 y1 x2 y2 x3 y3  AddPathCurve()
; Z                    ClosePath()
;可以通过PathSegments()来获取路径的节点描述.

If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathSegments_节点路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      Segments$ = "M 40 20 L 120 20 L 120 60 L 200 60 L 200 100 L 280 100 L 280 140 L 360 140 L 360 180"
      AddPathSegments(Segments$)
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
; CursorPosition = 16
; EnableXP