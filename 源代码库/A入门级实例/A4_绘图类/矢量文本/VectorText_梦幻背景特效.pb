;***********************************
;迷路仟整理 2019.02.09
;VectorText_梦幻背景特效
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


Procedure Vector_TextStyle()
   hFont = FontID(#fntScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorFont(hFont, 110)        ;使用矢量字体,并设置大小,无视#fntScreen的大小
      ;画字符
      VectorSourceColor($FF1880FF)  ;定义路径颜色
      MovePathCursor(50, 50)        ;设置起始点
      AddPathText("PureBasic")      ;添加文本
      DashPath(999, 1)
      StopVectorDrawing()
   EndIf 
EndProcedure



hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)
If OpenWindow(#winScreen, 0, 0, 600, 250, "VectorText_梦幻背景特效", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 250)
   Vector_TextStyle()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP