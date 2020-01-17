;***********************************
;迷路仟整理 2019.01.24
;VectorSourceImage_图像渲染效果
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0
#fntScreen = 0

hImage = LoadImage(#imgScreen, "..\Background.bmp")
hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)

If OpenWindow(#winScreen, 0, 0, 500, 250, "VectorSourceImage_图像渲染效果", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

      AddPathBox(050, 050, 200, 050)
      AddPathBox(150, 075, 200, 050)
      VectorSourceImage(hImage, 255, ImageWidth(#imgScreen), ImageHeight(#imgScreen), #PB_VectorImage_Repeat)
     
      VectorFont(hFont, 90)
      MovePathCursor(050, 130)
      DrawVectorText("PureBasic")
     
      StrokePath(10)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP