;***********************************
;迷路仟整理 2019.01.24
;RotateCoordinates_旋转坐标系
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0
;注意: 涉及到坐标系命令,都会对后面的命令直接产生影响,
;      如果需要消除影响,需要用到SaveVectorState()/RestoreVectorState()
;      如: ScaleCoordinates(), RotateCoordinates(), TranslateCoordinates(),SkewCoordinates(),
;          ResetCoordinates(),FlipCoordinatesX(),FlipCoordinatesY()
hFont = LoadFont(#fntScreen, "宋体", 60, #PB_Font_Bold)

If OpenWindow(#winScreen, 0, 0, 500, 250, "RotateCoordinates_旋转坐标系", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
   
      VectorFont(hFont)
      VectorSourceColor(RGBA(0, 0, 255, 128))
      MovePathCursor(50, 50)             
      DrawVectorText("PureBasic")
      
      
      FlipCoordinatesX(250)
      VectorSourceColor(RGBA(255, 0, 0, 128))
      MovePathCursor(50, 150)         
      DrawVectorText("PureBasic")  



      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; FirstLine = 3
; EnableXP