;***********************************
;迷路仟整理 2019.01.20
;UseFont_使用字体
;***********************************

Enumeration
   #winScreen
   #picScreen
   #imgScreen
   #fntScreen1
   #fntScreen2
EndEnumeration

;加载字体
LoadFont (#fntScreen1, "宋体",     14) 
LoadFont (#fntScreen2, "微软雅黑", 24) 

;生成图片
If CreateImage(#imgScreen, 500, 250)
   If StartDrawing(ImageOutput(#imgScreen))           ;
      Box(0, 0, 500, 250, RGB(255, 255, 225)) 
      DrawingMode(#PB_2DDrawing_Transparent)                    
      DrawingFont(FontID(#fntScreen1))      
      DrawText(010,050, "字体: 宋体     - 大小: 14 - 红色", RGB(255, 0, 0))  
                
      DrawingFont(FontID(#fntScreen2)) 
      DrawText(010,100, "字体: 微软雅黑 - 大小: 24 - 蓝色", RGB(0, 0, 255))
      StopDrawing()                
   EndIf                                   
EndIf



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "UseFont_使用字体", WindowFlags)
ImageGadget(#picScreen, 0, 0, 0, 0, ImageID(#imgScreen))
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
FreeFont(#fntScreen1) ;注销字体
FreeFont(#fntScreen2)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; FirstLine = 23
; Folding = -
; EnableXP