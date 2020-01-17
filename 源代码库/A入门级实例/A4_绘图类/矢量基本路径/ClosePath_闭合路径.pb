;***********************************
;迷路仟整理 2019.01.24
;ClosePath_闭合路径
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "ClosePath_闭合路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      ; 创建两个闭合的三角形路径
      MovePathCursor(020, 160)
      AddPathLine(100, 020)
      AddPathLine(180, 160)
      ClosePath()
      
      MovePathCursor(220, 160)
      AddPathLine(300, 020)
      AddPathLine(380, 160)
      ClosePath()      

      ; 充填路径
      VectorSourceColor(RGBA(255, 128, 0, 255))
      FillPath()

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; FirstLine = 1
; EnableXP