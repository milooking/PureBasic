;***********************************
;迷路仟整理 2019.01.24
;VectorSourceLinearGradient_线形渐变效果
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 500, 350, "VectorSourceLinearGradient_线形渐变效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 350)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceCircularGradient(250, 175, 150, -75, -75)
      VectorSourceGradientColor(RGBA(255, 255, 255, 255), 0.0)
      VectorSourceGradientColor(RGBA(255, 128, 0, 255), 1.0)
      FillVectorOutput()
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP