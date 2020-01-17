;***********************************
;迷路仟整理 2019.02.09
;VectorText_外发光效果
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


Procedure Vector_TextStyle()
   hFont = FontID(#fntScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FF808080)  ;绘制背景色
      FillVectorOutput()
      VectorFont(hFont, 110)        ;使用矢量字体,并设置大小,无视#fntScreen的大小
      ;画边缘
      For Width = 10 To 1 Step -3
         VectorSourceColor($6000FFFF)  ;定义路径颜色
         MovePathCursor(50, 50)        ;设置起始点    
         AddPathText("PureBasic")      ;添加文本
         StrokePath(Width)  
      Next 

      ;画字符
      VectorSourceColor($FF0080FF)  ;定义路径颜色
      MovePathCursor(50, 50)        ;设置起始点
      AddPathText("PureBasic")      ;添加文本
      FillPath()          
      StopVectorDrawing()
   EndIf 
EndProcedure



hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)
If OpenWindow(#winScreen, 0, 0, 600, 250, "VectorText_外发光效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 250)
   Vector_TextStyle()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; Folding = -
; EnableXP