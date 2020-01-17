;***********************************
;迷路仟整理 2019.02.15
;平面绘图_亮度调整
;***********************************

Enumeration
   #winScreen
   #lblBright
   #trkBright
   #cvsScreen
   #imgScreen
EndEnumeration


Global _AddBright


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor) + _AddBright
   G = Green(SourceColor) + _AddBright
   B = Blue (SourceColor) + _AddBright
   A = Alpha(SourceColor)
   
   If R < 0 : R = 0 : ElseIf R > 255 : R = 255 : EndIf 
   If G < 0 : G = 0 : ElseIf G > 255 : G = 255 : EndIf 
   If B < 0 : B = 0 : ElseIf B > 255 : B = 255 : EndIf 
   ProcedureReturn RGBA(R, G, B, A)
EndProcedure

Procedure Window_Drawing()
   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawingMode(#PB_2DDrawing_CustomFilter)      
      CustomFilterCallback(@Filter_Callback())
      DrawImage(ImageID(#imgScreen), 0, 0)
      StopDrawing()
   EndIf
EndProcedure

Procedure EventGadget_trkBright()
   _AddBright = GetGadgetState(#trkBright) - 255
   If _AddBright >= 0
      SetGadgetText(#lblBright, "亮度: +"+Str(_AddBright))
   Else 
      SetGadgetText(#lblBright, "亮度: "+Str(_AddBright))
   EndIf
   Window_Drawing()
EndProcedure





hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 610, 255, "平面绘图_亮度调整", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblBright, 010, 015, 060, 020, "亮度: +0")
   TrackBarGadget(#trkBright, 080, 010, 512, 025, 0, 510)
   CanvasGadget(#cvsScreen, 105, 045, 400, 200)
   SetGadgetState(#trkBright, 256)
   BindGadgetEvent(#trkBright, @EventGadget_trkBright())


   Window_Drawing()


   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; FirstLine = 2
; Folding = -
; EnableXP