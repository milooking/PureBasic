;***********************************
;迷路仟整理 2019.02.09
;BoolPath_路径布尔域
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 600, 200, "BoolPath_路径布尔域", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 600, 200)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

      VectorSourceColor($FF808080)
      FillVectorOutput()

      BeginVectorLayer() 
         MovePathCursor(100,100)
         VectorSourceColor($FF78DCD9)
         
         AddPathCircle(100,100,80)
         MovePathCursor(150,100)
         AddPathCircle(150,100,50)
         FillPath()
      EndVectorLayer()
; 
      BeginVectorLayer() 
         MovePathCursor(300,100)
         AddPathCircle(300,100,50)
         ClipPath()
         MovePathCursor(250,100)
         VectorSourceColor($FF78DCD9)
         AddPathCircle(250,100,80)
         FillPath()
      EndVectorLayer()
; 
      BeginVectorLayer() 
         MovePathCursor(500,100)
         VectorSourceColor($FF78DCD9)
         AddPathCircle(500,100,80)
         FillPath()
         VectorSourceColor($FF808080)
         MovePathCursor(550,100)
         AddPathCircle(550,100,50)
         FillPath()
      EndVectorLayer()  


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