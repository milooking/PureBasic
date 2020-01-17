;***********************************
;迷路仟整理 2019.01.24
;AddPathArc_弧线路径
;***********************************

#winScreen = 0
#cvsScreen = 0

;AddPathArc_弧线路径的原理是这样的:
;将上一路径的结束点视为(x0,y0), 通过AddPathArc()中,(x1,y1), (x2,y2)这两个点,
;形成一个以(x0,y0)-(x1,y1)和(x2,y2)-(x1,y1)为边,以(x1,y1)为夹角顶点的角.
;在夹角处进行圆角处理,形成弧线.

If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathArc_弧线路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(40, 60)                    ;设置一个路径起始坐标点
      AddPathArc(100, 140, 160, 020, 020)       ;添加一段圆弧
      AddPathArc(160, 020, 220, 180, 020)
      AddPathArc(044, 117, 104, 058, 020, #PB_Path_Relative) ;相对于上一个路径的位置
      AddPathArc(280, 080, 340, 120, 020)
      AddPathLine(340, 120)                     ;添加一条直线
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
; CursorPosition = 17
; EnableXP