;***********************************
;迷路仟整理 2019.01.23
;DrawingBuffer_当前像素指针
;***********************************

#winScreen = 0
#picScreen = 0

ImageID = CreateImage(#PB_Any, 400, 250, 32, $FFFFFFFF)
If ImageID
   If StartDrawing(ImageOutput(ImageID))
      *pMemBuffer = DrawingBuffer()       ;获取当前画板的指针
      For R = 0 To 250-1
         For C = 0 To 400-1
            *pPoint.long = *pMemBuffer + R * 400 * 4 + C * 4
            *pPoint\l = $FF0000FF
         Next 
      Next 
      ;相当于 Box(000,000,400,250, $FF0000FF)
      
      For R = 100 To 150-1
         For C = 100 To 300-1
            *pPoint.long = *pMemBuffer + R * 400 * 4 + C * 4
            *pPoint\l = $FFFF0000
         Next 
      Next 
      ;相当于 Box(100,100,200,050, $FFFF0000)
      ShowMemoryViewer(*pMemBuffer, 400*250*4)  ;查看画板的内存数据
      StopDrawing()
   EndIf
EndIf


If OpenWindow(#winScreen, 0, 0, 400, 250, "DrawingBuffer_当前像素指针", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   ImageGadget(#picScreen,0,0,0,0, ImageID(ImageID)) ;图像控件会随着图像的大小而自动调整自身的大小
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
FreeImage(ImageID)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; FirstLine = 15
; EnableXP