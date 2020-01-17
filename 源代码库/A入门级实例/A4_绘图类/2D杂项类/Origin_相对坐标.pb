;***********************************
;迷路仟整理 2019.01.23
;Origin_相对坐标
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 300, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      For x = 0 To 400 Step 41
         For y = 0 To 250 Step 43
            SetOrigin(x, y)            ;设置新的坐标体系
            Box   (00, 00, 30, 30, $FF0000)
            Circle(15, 15, 10, $00FF00)
         Next
      Next
      Debug "当前坐标系统: X = " + GetOriginX()    ;获取当前坐标系的X坐标
      Debug "当前坐标系统: Y = " + GetOriginY()    ;获取当前坐标系的Y坐标
      ;SetOrigin(0, 0) ;恢复原来的坐标系统
      StopDrawing()
   EndIf
EndIf

If OpenWindow(#winScreen, 0, 0, 400, 250, "Origin_相对坐标", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP