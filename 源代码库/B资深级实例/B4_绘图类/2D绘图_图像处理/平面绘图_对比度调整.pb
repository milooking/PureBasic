;***********************************
;迷路仟整理 2019.02.15
;平面绘图_对比度调整
;***********************************

Enumeration
   #winScreen
   #lblContrast
   #trkContrast
   #cvsScreen
   #imgScreen
EndEnumeration


Global _AddContrast


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor)
   G = Green(SourceColor) 
   B = Blue (SourceColor)
   A = Alpha(SourceColor)
   
   R + (R-127.5) * _AddContrast/100   
   G + (G-127.5) * _AddContrast/100   
   B + (B-127.5) * _AddContrast/100   
   
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

Procedure EventGadget_trkContrast()
   _AddContrast = GetGadgetState(#trkContrast) - 50
   If _AddContrast >= 0
      SetGadgetText(#lblContrast, "对比度: +"+Str(_AddContrast))
   Else 
      SetGadgetText(#lblContrast, "对比度: "+Str(_AddContrast))
   EndIf
   Window_Drawing()
EndProcedure





hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 420, 255, "平面绘图_对比度调整", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblContrast, 010, 015, 080, 020, "对比度: +0")
   TrackBarGadget(#trkContrast, 090, 010, 151, 025, 0, 150)
   CanvasGadget(#cvsScreen, 010, 045, 400, 200)
   SetGadgetState(#trkContrast, 50)
   BindGadgetEvent(#trkContrast, @EventGadget_trkContrast())


   Window_Drawing()


   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP