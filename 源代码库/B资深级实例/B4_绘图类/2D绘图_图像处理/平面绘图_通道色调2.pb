;***********************************
;迷路仟整理 2019.02.13
;平面绘图_通道色调2
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
   R = Red  (SourceColor) * (100 + _AddColorR)/100
   G = Green(SourceColor) * (100 + _AddColorG)/100
   B = Blue (SourceColor) * (100 + _AddColorB)/100
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
   _AddColorR = GetGadgetState(#trkColorR) - 100
   _AddColorG = GetGadgetState(#trkColorG) - 100
   _AddColorB = GetGadgetState(#trkColorB) - 100
   If _AddColorR >= 0
      SetGadgetText(#lblColorR, "R: +"+Str(_AddColorR)+"%")
   Else 
      SetGadgetText(#lblColorR, "R: "+Str(_AddColorR)+"%")
   EndIf
   
   If _AddColorG >= 0
      SetGadgetText(#lblColorG, "G: +"+Str(_AddColorG)+"%")
   Else 
      SetGadgetText(#lblColorG, "G: "+Str(_AddColorG)+"%")
   EndIf   
   
   If _AddColorB >= 0
      SetGadgetText(#lblColorB, "B: +"+Str(_AddColorB)+"%")
   Else 
      SetGadgetText(#lblColorB, "B: "+Str(_AddColorB)+"%")
   EndIf   
   Window_Drawing()
EndProcedure





hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 420, 310, "平面绘图_通道色调2", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblColorR, 010, 015, 060, 020, "R: +0%")
   TextGadget(#lblColorG, 010, 045, 060, 020, "G: +0%")
   TextGadget(#lblColorB, 010, 075, 060, 020, "B: +0%")
   
   TrackBarGadget(#trkColorR, 070, 010, 201, 025, 0, 200)
   TrackBarGadget(#trkColorG, 070, 040, 201, 025, 0, 200)
   TrackBarGadget(#trkColorB, 070, 070, 201, 025, 0, 200)

   CanvasGadget(#cvsScreen, 010, 100, 400, 200)

   SetGadgetState(#trkColorR, 100)
   SetGadgetState(#trkColorG, 100)
   SetGadgetState(#trkColorB, 100)
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
; CursorPosition = 6
; Folding = -
; EnableXP