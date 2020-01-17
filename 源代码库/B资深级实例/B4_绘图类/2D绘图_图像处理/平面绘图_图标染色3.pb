;***********************************
;迷路仟整理 2019.02.13
;平面绘图_图标染色:Filter
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
EndEnumeration

      
Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   Alpha = Alpha(SourceColor)
   If Alpha 
      If x >= 240 And y >= 050
         ProcedureReturn RGBA(255, 000, 128, Alpha)
      ElseIf x >= 160 And y >= 050
         ProcedureReturn RGBA(255, 128, 000, Alpha)
      ElseIf x >= 080 And y >= 050
         ProcedureReturn RGBA(255, 000, 255, Alpha)
      EndIf 
   Else 
      ProcedureReturn TargetColor
   EndIf
EndProcedure

UseTGAImageDecoder()
hImage = LoadImage(#imgScreen, "..\游戏手柄.tga")

If OpenWindow(#winScreen, 000, 000, 400, 200, "平面绘图_图标染色:Filter", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 200)

   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(0, 0, 400, 250, $FFFFFFFF)
      DrawingMode(#PB_2DDrawing_CustomFilter)      
      CustomFilterCallback(@Filter_Callback())
      DrawImage(hImage, 080, 050)
      DrawImage(hImage, 160, 050) 
      DrawImage(hImage, 240, 050) 
      StopDrawing()
   EndIf


   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP