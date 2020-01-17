;***********************************
;迷路仟整理 2019.02.11
;平面绘图_图标染色:Alpha通道
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
EndEnumeration


UseTGAImageDecoder() 
hImage = LoadImage(#imgScreen, "..\游戏手柄.tga")

If OpenWindow(#winScreen, 000, 000, 400, 200, "平面绘图_图标染色:Alpha通道", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 200)
   
   ImageID = CreateImage(#PB_Any, 400, 200,32)
   If StartDrawing(ImageOutput(ImageID))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(000, 000, 400, 200, $000000)
      
      Box(080, 050, 060, 060, $00FF00FF)
      Box(160, 050, 060, 060, $000080FF)
      Box(240, 050, 060, 060, $00FF0080)
      
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawImage(hImage, 080, 050) 
      DrawImage(hImage, 160, 050) 
      DrawImage(hImage, 240, 050) 

      StopDrawing()
   EndIf   

   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawingMode(#PB_2DDrawing_Default)
      DrawAlphaImage(ImageID(ImageID), 0, 0)
      StopDrawing()
   EndIf
   
   
   FreeImage(ImageID)

   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP