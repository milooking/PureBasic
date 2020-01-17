;***********************************
;迷路仟整理 2019.02.15
;平面绘图_自然饱合度调整
;***********************************

Enumeration
   #winScreen
   #lblVibrance
   #trkVibrance
   #cvsScreen
   #imgScreen
EndEnumeration


Global _AddVibrance


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor) 
   G = Green(SourceColor) 
   B = Blue (SourceColor) 
   A = Alpha(SourceColor)
   Gray = (R * 299 + G * 587 + B * 114)/1000

   Max = G
   If Max < B : Max = B : EndIf 
   If Max < R : Max = R : EndIf 

   Increment.f = Abs(Max - Gray)* _AddVibrance/100/127
   R - (Max - R) * Increment
   G - (Max - G) * Increment
   B - (Max - B) * Increment

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

Procedure EventGadget_trkVibrance()
   _AddVibrance = GetGadgetState(#trkVibrance) - 100
   If _AddVibrance >= 0
      SetGadgetText(#lblVibrance, "饱合度: +"+Str(_AddVibrance))
   Else 
      SetGadgetText(#lblVibrance, "饱合度: "+Str(_AddVibrance))
   EndIf
   Window_Drawing()
EndProcedure



hImage = LoadImage(#imgScreen, "..\Background.bmp")

If OpenWindow(#winScreen, 000, 000, 420, 255, "平面绘图_自然饱合度调整", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   TextGadget(#lblVibrance, 010, 015, 080, 020, "饱合度: +0")
   TrackBarGadget(#trkVibrance, 090, 010, 201, 025, 0, 200)
   CanvasGadget(#cvsScreen, 010, 045, 400, 200)
   SetGadgetState(#trkVibrance, 100)
   BindGadgetEvent(#trkVibrance, @EventGadget_trkVibrance())


   Window_Drawing()


   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 6
; Folding = -
; EnableXP