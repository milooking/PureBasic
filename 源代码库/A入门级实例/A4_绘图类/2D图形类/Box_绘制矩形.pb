;***********************************
;迷路仟整理 2019.01.22
;Box_绘制矩形
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 200, 24, $FFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      For x = 0 To 95 Step 10
         Box(x, y, 400-2*x, 200-2*y, RGB(Random(255), Random(255), Random(255)))
         y + 10        ; 相当于 y = y + 10
      Next x
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 200, "Box_绘制矩形", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; EnableXP