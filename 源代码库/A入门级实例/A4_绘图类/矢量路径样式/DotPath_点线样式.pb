;***********************************
;迷路仟整理 2019.01.24
;DotPath_点线样式
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "DotPath_点线样式", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      MovePathCursor(50, 20)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 80, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DotPath(5, 18)                               ;默认方形点
      
      MovePathCursor(200, 20)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 80, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DotPath(5, 18, #PB_Path_RoundEnd)            ;圆形点


      MovePathCursor(50, 120)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 80, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DotPath(10, 18)                               ;默认方形点
      
      MovePathCursor(200, 120)
      AddPathLine(80, 0, #PB_Path_Relative)
      AddPathLine(0, 80, #PB_Path_Relative)
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DotPath(10, 18, #PB_Path_RoundEnd)            ;圆形点
      
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP