;***********************************
;迷路仟整理 2019.02.06
;GrayImage_灰度图像
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
EndEnumeration


Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   R = Red  (SourceColor)
   G = Green(SourceColor)
   B = Blue (SourceColor)
   A = Alpha(SourceColor)
   Gray = (R * 299 + G * 587 + B * 114)/1000
   ProcedureReturn RGBA(Gray, Gray, Gray, A)
EndProcedure


hImage = LoadImage(#imgScreen, "..\Background.bmp")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "GrayImage_灰度图像", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, 400, 250)
If StartDrawing(CanvasOutput(#cvsScreen))
   Box(0, 0, 400, 250, $FFFFFFFF)
   DrawingMode(#PB_2DDrawing_CustomFilter)      
   CustomFilterCallback(@Filter_Callback())
   DrawImage(ImageID(#imgScreen), 0, 0)
   StopDrawing()
EndIf

Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; Folding = -
; EnableXP
; EnableUnicode