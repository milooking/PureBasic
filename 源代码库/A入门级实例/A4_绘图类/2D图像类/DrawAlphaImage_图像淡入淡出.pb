;***********************************
;迷路仟整理 2019.02.08
;DrawAlphaImage_图像淡入淡出
;***********************************

Enumeration
   #winScreen
   #imgScreen
   #tmrScreen
EndEnumeration


hImage = LoadImage(#imgScreen, "..\Background.bmp")

FadeValue = -255

If OpenWindow(#winScreen, 0, 0, 400, 200, "DrawAlphaImage_图像淡入淡出", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   AddWindowTimer(#winScreen, #tmrScreen, 50)
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer
            If EventTimer() = #tmrScreen And FadeValue < 256
               If StartDrawing(WindowOutput(#winScreen))
                  Box(0, 0, 400, 200, $F0F0F0)
                  DrawAlphaImage(hImage, 0, 0, Abs(FadeValue))
                  StopDrawing()
               EndIf
               Debug FadeValue
               FadeValue+5
            EndIf 
      EndSelect
   Until IsExitWindow = #True
EndIf 
FreeImage(#imgScreen)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP