;***********************************
;迷路仟整理 2019.01.23
;CreateImage_创建图像
;***********************************

Enumeration
   #winScreen
   #imgScreen
   #picScreen1
   #picScreen2
   #picScreen3
EndEnumeration


;创建图像,默认是24位位图,不支持透明效果
hImage = CreateImage(#imgScreen, 100, 100)
If hImage
   If StartDrawing(ImageOutput(#imgScreen))
      Box(000,000,100,100, $FFFFFF)    ;背景色
      Circle(050,050,045, $E000E0)     ;画个圆
      Box   (025,025,050,050,$008000)  ;画个矩形
      StopDrawing()
   EndIf
EndIf

;创建图像,24位位图,自带背景色
ImageID = CreateImage(#PB_Any, 100, 100, 24, $808080)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      Circle(050,050,045, $E000E0)     ;画个圆
      Box   (025,025,050,050,$008000)  ;画个矩形
      StopDrawing()
   EndIf
EndIf

;创建图像,32位位图
AlphaID = CreateImage(#PB_Any, 100, 100, 32)
If AlphaID
   If StartDrawing(ImageOutput(AlphaID))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(000,000,100,100, $00000000)   ;透明背景
      Circle(050,050,045,  $FFE000E0)   ;画个圆
      Box   (025,025,050,050,$00000000) ;画个矩形
      StopDrawing()
   EndIf
EndIf



If OpenWindow(#winScreen, 0, 0, 400, 200, "CreateImage_创建图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   SetWindowColor(#winScreen, $CFFFFF)
   ImageGadget(#picScreen1, 040, 050, 100, 100, ImageID(#imgScreen))
   ImageGadget(#picScreen2, 150, 050, 100, 100, ImageID(ImageID))
   ImageGadget(#picScreen3, 260, 050, 100, 100, ImageID(AlphaID))
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(#imgScreen)   ;注销图像
FreeImage(ImageID)
FreeImage(AlphaID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 58
; FirstLine = 36
; Folding = -
; EnableXP