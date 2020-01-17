;***********************************
;迷路仟整理 2019.01.24
;PathBounds_获取路径域大小
;***********************************

;PathBoundsX()
;PathBoundsY()
;PathBoundsWidth()
;PathBoundsHeight()
      
#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "PathBounds_获取路径域大小", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

      ;创建一个路径
      MovePathCursor(150, 125)
      AddPathCurve(0, 270, 0, -150, 350, 180)
      
      ; 获取路径域大小信息
      x = PathBoundsX()
      y = PathBoundsY()
      w = PathBoundsWidth()
      h = PathBoundsHeight()
      
      VectorSourceColor($FF0000FF)
      StrokePath(5)
      
      ; 将路径域标识出来
      AddPathBox(x, y, w, h)
      VectorSourceColor($FF000000)
      DashPath(2, 5)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; EnableXP