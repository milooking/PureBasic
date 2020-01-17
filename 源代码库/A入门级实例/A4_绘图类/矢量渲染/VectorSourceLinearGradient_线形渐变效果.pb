;***********************************
;迷路仟整理 2019.01.24
;VectorSourceLinearGradient_线形渐变效果
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 500, 250, "VectorSourceLinearGradient_线形渐变效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceLinearGradient(50, 0, 450, 0)
      VectorSourceGradientColor(RGBA(255, 0, 0, 255), 0.0)
      VectorSourceGradientColor(RGBA(0, 255, 0, 255), 0.5)
      VectorSourceGradientColor(RGBA(0, 0, 255, 255), 1.0)
      AddPathBox(50, 25, 400, 200)
      FillPath()
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP