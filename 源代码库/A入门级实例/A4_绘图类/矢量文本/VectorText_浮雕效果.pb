﻿;***********************************
;迷路仟整理 2019.02.07
;VectorText_浮雕效果
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


Procedure Vector_TextStyle()
   hFont = FontID(#fntScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($80808080)  ;绘制背景色
      FillVectorOutput()
      VectorFont(hFont, 110)        ;使用矢量字体,并设置大小,无视#fntScreen的大小
      ;画高亮区
      VectorSourceColor($FFFFFFFF)  ;定义路径颜色
      MovePathCursor(50, 50)        ;设置起始点
      AddPathText("PureBasic")      ;添加文本
      FillPath()  
        
      ;画阴影区
      VectorSourceColor($FF004080)  ;定义路径颜色
      MovePathCursor(53, 53)        ;设置起始点
      AddPathText("PureBasic")      ;添加文本
      FillPath()          
         
      ;画字符
      VectorSourceColor($FF0080FF)  ;定义路径颜色
      MovePathCursor(51, 51)        ;设置起始点
      AddPathText("PureBasic")      ;添加文本
      FillPath()                      
      StopVectorDrawing()
   EndIf 
EndProcedure



hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)
If OpenWindow(#winScreen, 0, 0, 600, 250, "VectorText_浮雕效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 250)
   Vector_TextStyle()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 42
; FirstLine = 21
; Folding = -
; EnableXP