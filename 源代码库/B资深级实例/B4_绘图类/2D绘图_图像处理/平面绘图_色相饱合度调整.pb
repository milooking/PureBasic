;***********************************
;迷路仟整理 2019.02.15
;平面绘图_色相饱合度调整
;***********************************

Enumeration
   #winScreen
   #lblSaturation
   #trkSaturation
   #cvsScreen
   #imgScreen
EndEnumeration


Global _AddSaturation


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor) 
   G = Green(SourceColor) 
   B = Blue (SourceColor) 
   A = Alpha(SourceColor)
   
   Max = G
   If Max < B : Max = B : EndIf 
   If Max < R : Max = R : EndIf 
   Min = R 
   If Min > B : Min = B : EndIf 
   If Min > G : Min = G : EndIf 
   Delta = Max-Min
   Value = Max+Min
   If Delta = 0
      ProcedureReturn SourceColor
   EndIf 
   
   
   L.f = Value/2
   If Value < 255
      S.f = Delta / Value
   Else 
      S.f = Delta /(510- Value)
   EndIf 

   Increment.f = _AddSaturation/100
   If Increment >= 0
      If Increment + S >= 1 
         Alpha.f = S
      Else 
         Alpha.f = 1-Increment
      EndIf 
      Alpha = 1/Alpha-1
      R + (R-L)*Alpha
      G + (G-L)*Alpha
      B + (B-L)*Alpha
   Else
      Alpha.f = 1+Increment
      R = L + (R-L) * Alpha;
      G = L + (G-L) * Alpha
      B = L + (B-L) * Alpha
   EndIf 

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

Procedure EventGadget_trkSaturation()
   _AddSaturation = GetGadgetState(#trkSaturation) - 100
   If _AddSaturation >= 0
      SetGadgetText(#lblSaturation, "饱合度: +"+Str(_AddSaturation))
   Else 
      SetGadgetText(#lblSaturation, "饱合度: "+Str(_AddSaturation))
   EndIf
   Window_Drawing()
EndProcedure



hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 420, 255, "平面绘图_色相饱合度调整", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblSaturation, 010, 015, 080, 020, "饱合度: +0")
   TrackBarGadget(#trkSaturation, 090, 010, 201, 025, 0, 200)
   CanvasGadget(#cvsScreen, 010, 045, 400, 200)
   SetGadgetState(#trkSaturation, 100)
   BindGadgetEvent(#trkSaturation, @EventGadget_trkSaturation())
   Window_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 97
; FirstLine = 65
; Folding = -
; EnableXP