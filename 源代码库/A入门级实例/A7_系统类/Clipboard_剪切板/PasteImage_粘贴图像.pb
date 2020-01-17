;***********************************
;迷路仟整理 2019.02.06
;PasteImage_粘贴图像
;***********************************

Enumeration
   #winScreen
   #btnScreen
   #cvsScreen
   #imgScreen
EndEnumeration

Procedure Event_PasteImage()
   GetClipboardImage(#imgScreen, 32)
   If IsImage(#imgScreen) 
      If StartDrawing(CanvasOutput(#cvsScreen))
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(0, 0, OutputWidth(), OutputHeight(), RGBA(255, 255, 255, 255))
         DrawImage(ImageID(#imgScreen), 0, 0)
         StopDrawing()
      EndIf
      FreeImage(#imgScreen)
   EndIf

EndProcedure


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 420, 310, "PasteImage_粘贴图像", WindowFlags)

ButtonGadget(#btnScreen, 010, 010, 080, 030, "粘贴图像")
CanvasGadget(#cvsScreen, 010, 050, 400, 250)

BindGadgetEvent(#btnScreen, @Event_PasteImage())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP