;***********************************
;迷路仟整理 2019.01.24
;AddPathLine_线段路径
;***********************************

#winScreen = 0
#cvsScreen = 0

;AddPathLine_线段路径原理:
;将上一路径的结束点视为(x0,y0), 通过AddPathLine()中(x,y),形成一条线段,


If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathLine_线段路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(40, 50)                    ;设置路径起始点
      For i = 1 To 4
        AddPathLine(80, 00, #PB_Path_Relative)  ;添加一条线段,相对于上一个路径的位置
        AddPathLine(00, 40, #PB_Path_Relative)  ;添加一条线段,相对于上一个路径的位置
      Next i
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
; CursorPosition = 21
; EnableXP