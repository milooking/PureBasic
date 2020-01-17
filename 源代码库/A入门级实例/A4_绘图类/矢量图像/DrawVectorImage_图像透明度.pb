;***********************************
;迷路仟整理 2019.02.12
;DrawVectorImage_图像透明度
;***********************************

Enumeration
   #winScreen
   #lblScreen
   #trkScreen
   #cvsScreen
   #imgScreen
EndEnumeration

Procedure Vector_Drawing()
   Transparency = GetGadgetState(#trkScreen)
   hImage = ImageID(#imgScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      DrawVectorImage(hImage, Transparency)
      StopVectorDrawing()
   EndIf 
EndProcedure

hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 0, 0, 400, 300, "DrawVectorImage_图像透明度", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget    (#lblScreen, 010, 015, 060, 020, "透明度:")
   TrackBarGadget(#trkScreen, 060, 010, 256, 025, 0, 255)
   CanvasGadget  (#cvsScreen, 000, 050, 400, 250)
   SetGadgetState(#trkScreen, 50)
   Vector_Drawing()
   BindGadgetEvent(#trkScreen, @Vector_Drawing())
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 21
; Folding = -
; EnableXP