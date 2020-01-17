;***********************************
;迷路仟整理 2019.01.24
;DrawVectorText_绘制矢量文本
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)

If OpenWindow(#winScreen, 0, 0, 500, 400, "DrawVectorText_绘制矢量文本", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 400)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorFont(hFont, 25)
      VectorSourceColor(RGBA(255, 128, 000, 200))
      Text$ = "--PureBasic--"
      X = 250 + 30
      Y = 200 - VectorTextHeight(Text$)/2
      ;每绘制一次,画板都旋30度
      For i = 1 To 12
        MovePathCursor(X, Y)
        DrawVectorText(Text$)
        RotateCoordinates(250, 200, 30)
      Next i

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; FirstLine = 10
; EnableXP