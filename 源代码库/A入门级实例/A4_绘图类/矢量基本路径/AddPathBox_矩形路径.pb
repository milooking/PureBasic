;***********************************
;迷路仟整理 2019.01.24
;AddPathBox_矩形路径
;***********************************

#winScreen = 0
#cvsScreen = 0



If OpenWindow(#winScreen, 0, 0, 400, 250, "AddPathBox_矩形路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      AddPathBox(050, 030, 200, 50)             ;添加一个矩形路径
      AddPathBox(150, 065, 200, 50)
      AddPathBox(-100,030, 200, 50, #PB_Path_Relative)   ;注意X,Y的值,是相对于上一个路径的位置
      AddPathBox(150, 130, 200, 50, #PB_Path_Connected)  ;从上一路径连线过来
      
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
; CursorPosition = 8
; EnableXP