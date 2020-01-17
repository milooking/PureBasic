;***********************************
;迷路仟整理 2019.02.16
;DrawImage_图像水印,通过灰度计算进行水印
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
   #fntScreen
EndEnumeration

Procedure Filter_Callback(x, y, SourceColor, TargetColor)

   Alpha = Alpha(SourceColor)
   If Alpha 
      R = Red  (TargetColor)
      G = Green(TargetColor) 
      B = Blue (TargetColor)
      Gray = (R * 299 + G * 587 + B * 114)/1000
      If Gray < 128 : Gray-10 : Else : Gray+10 : EndIf 
      ProcedureReturn RGBA(Gray,Gray,Gray, Alpha)
   Else 
      ProcedureReturn TargetColor
   EndIf 
EndProcedure

Procedure Window_Drawing()
   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawImage(ImageID(#imgScreen), 0, 0)
      DrawingMode(#PB_2DDrawing_CustomFilter|#PB_2DDrawing_AlphaBlend)      
      CustomFilterCallback(@Filter_Callback())
      DrawingFont(FontID(#fntScreen))
      For R = 10 To 400 Step 60
         For C = 10 To 400 Step 120
            DrawRotatedText(C, R, "PureBasic", 30, RGBA(128,128,128,255))
         Next
      Next
      StopDrawing()
   EndIf
EndProcedure

hFont  = LoadFont(#fntScreen, "", 16)
hImage = LoadImage(#imgScreen, "..\Background.bmp")


If OpenWindow(#winScreen, 0, 0, 400, 200, "DrawImage_图像水印", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 200)
   Window_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP