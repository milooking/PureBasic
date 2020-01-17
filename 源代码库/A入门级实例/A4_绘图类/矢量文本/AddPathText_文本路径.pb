;***********************************
;迷路仟整理 2019.01.24
;AddPathText_文本路径
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0

hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)
If OpenWindow(#winScreen, 0, 0, 600, 250, "AddPathText_文本路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorFont(hFont, 110)                    ;使用矢量字体,并设置大小,无视#fntScreen的大小
      MovePathCursor(50, 50)                    ;设置起始点
      AddPathText("PureBasic")                  ;添加文本
      VectorSourceColor(RGBA(255, 0, 0, 255))   ;定义路径颜色
      DashPath(2, 3)                            ;定义路径大小及样式,并呈现
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; FirstLine = 1
; EnableXP