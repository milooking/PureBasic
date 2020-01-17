;***********************************
;迷路仟整理 2019.01.24
;FillPath_填充路径
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 500, 250, "FillPath_填充路径", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
   

      AddPathBox(50, 50, 200, 50)
      AddPathBox(150, 75, 200, 50)
      VectorSourceColor(RGBA(0, 0, 255, 255))
      FillPath()

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP