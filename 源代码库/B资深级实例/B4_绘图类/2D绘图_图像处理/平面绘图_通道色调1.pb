;***********************************
;迷路仟整理 2019.02.13
;平面绘图_通道色调
;***********************************

Enumeration
   #winScreen
   #lblColorR
   #lblColorG
   #lblColorB
   #trkColorR
   #trkColorG
   #trkColorB
   #cvsScreen
   #imgScreen
EndEnumeration


Global _AddColorR, _AddColorG, _AddColorB


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor) + _AddColorR
   G = Green(SourceColor) + _AddColorG
   B = Blue (SourceColor) + _AddColorB
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

Procedure EventGadget_trkColor()
   _AddColorR = GetGadgetState(#trkColorR) - 255
   _AddColorG = GetGadgetState(#trkColorG) - 255
   _AddColorB = GetGadgetState(#trkColorB) - 255
   If _AddColorR >= 0
      SetGadgetText(#lblColorR, "R: +"+Str(_AddColorR))
   Else 
      SetGadgetText(#lblColorR, "R: "+Str(_AddColorR))
   EndIf
   
   If _AddColorG >= 0
      SetGadgetText(#lblColorG, "G: +"+Str(_AddColorG))
   Else 
      SetGadgetText(#lblColorG, "G: "+Str(_AddColorG))
   EndIf   
   
   If _AddColorB >= 0
      SetGadgetText(#lblColorB, "B: +"+Str(_AddColorB))
   Else 
      SetGadgetText(#lblColorB, "B: "+Str(_AddColorB))
   EndIf   
   Window_Drawing()
EndProcedure





hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 600, 310, "平面绘图_通道色调", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblColorR, 010, 015, 060, 020, "R: +000")
   TextGadget(#lblColorG, 010, 045, 060, 020, "G: +000")
   TextGadget(#lblColorB, 010, 075, 060, 020, "B: +000")
   
   TrackBarGadget(#trkColorR, 070, 010, 511, 025, 0, 510)
   TrackBarGadget(#trkColorG, 070, 040, 511, 025, 0, 510)
   TrackBarGadget(#trkColorB, 070, 070, 511, 025, 0, 510)

   CanvasGadget(#cvsScreen, 110, 100, 400, 200)

   SetGadgetState(#trkColorR, 255)
   SetGadgetState(#trkColorG, 255)
   SetGadgetState(#trkColorB, 255)
   BindGadgetEvent(#trkColorR, @EventGadget_trkColor())
   BindGadgetEvent(#trkColorG, @EventGadget_trkColor())
   BindGadgetEvent(#trkColorB, @EventGadget_trkColor())

   Window_Drawing()


   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 81
; FirstLine = 57
; Folding = -
; EnableXP