;***********************************
;迷路仟整理 2019.01.29
;ShowLibraryViewer_库对象查看器
;***********************************



If CreateImage(0, 200, 200)            ;创建一张图像
   If StartDrawing(ImageOutput(0))     ;绘制一张图像
      DrawingMode(#PB_2DDrawing_Transparent)
      Box(0, 0, 200, 200, RGB(255, 255, 255))
      For i = 1 To 30
         DrawText(Random(200), Random(200), "PureBasic!", RGB(Random(255), Random(255), Random(255)))
      Next i
      StopDrawing() 
      ShowLibraryViewer("Image", 0)    ; 显示图像
      CallDebugger                    ; 停止程序，使它不会立即结束
   EndIf 
EndIf








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; EnableXP