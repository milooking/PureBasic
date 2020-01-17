;***********************************
;迷路仟整理 2019.01.24
;StrokePath_实线样式
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "StrokePath_实线样式", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(50, 20)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18)                               ;默认方形线端
      
      MovePathCursor(200, 20)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18, #PB_Path_RoundEnd)            ;圆角线端 
      
      MovePathCursor(050, 100)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18, #PB_Path_RoundCorner)         ;圆角拐点 
      
      MovePathCursor(200, 100)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18, #PB_Path_DiagonalCorner)      ;倒角拐点       
           
           
      MovePathCursor(050, 180)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18, #PB_Path_RoundCorner|#PB_Path_RoundEnd) ;圆角拐点+ 圆角线端   

      
      MovePathCursor(200, 180)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 40, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(8, 18, #PB_Path_DiagonalCorner|#PB_Path_RoundEnd)   ;倒角拐点+ 圆角线端
       
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 43
; FirstLine = 15
; EnableXP