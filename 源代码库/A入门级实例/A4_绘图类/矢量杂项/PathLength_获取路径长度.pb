;***********************************
;迷路仟整理 2019.01.24
;PathLength_获取路径长度
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "PathLength_获取路径长度", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

      ;创建一个路径
      MovePathCursor(150, 125)
      AddPathCurve(0, 270, 0, -150, 350, 180)
      ; 获取长度
      Debug "路径长度: " + PathLength()
      VectorSourceColor($FF0000FF)
      StrokePath(5)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; EnableXP