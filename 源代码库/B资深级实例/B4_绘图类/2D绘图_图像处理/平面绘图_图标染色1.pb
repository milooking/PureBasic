;***********************************
;迷路仟整理 2019.02.11
;平面绘图_图标染色:透明法
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
EndEnumeration

UsePNGImageDecoder() 

hImage = LoadImage(#imgScreen, "..\游戏手柄.png")

If OpenWindow(#winScreen, 000, 000, 400, 200, "平面绘图_图标染色:透明法", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 200)
   
   ImageID1 = CopyImage(#imgScreen, #PB_Any)
   If StartDrawing(ImageOutput(ImageID1))
      Box(0, 0, 060, 060, $FFFF00FF)
      StopDrawing()
   EndIf   

   ImageID2 = CopyImage(#imgScreen, #PB_Any)
   If StartDrawing(ImageOutput(ImageID2))
      Box(0, 0, 060, 060, $FF0080FF)
      StopDrawing()
   EndIf  

   ImageID3 = CopyImage(#imgScreen, #PB_Any)
   If StartDrawing(ImageOutput(ImageID3))
      Box(0, 0, 060, 060, $FFFF0080)
      StopDrawing()
   EndIf  

   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawAlphaImage(ImageID(ImageID1), 080, 050)
      DrawAlphaImage(ImageID(ImageID2), 160, 050)
      DrawAlphaImage(ImageID(ImageID3), 240, 050)
      StopDrawing()
   EndIf
   
   
   FreeImage(ImageID1)
   FreeImage(ImageID2)
   FreeImage(ImageID3)
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; Folding = -
; EnableXP