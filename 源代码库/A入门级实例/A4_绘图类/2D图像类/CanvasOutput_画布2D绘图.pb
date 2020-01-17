;***********************************
;迷路仟整理 2019.01.22
;CanvasOutput_画布2D绘图
;***********************************


#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 200, "CanvasOutput_画布2D绘图", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   hGadget = CanvasGadget(#cvsScreen,0,0,400, 200)
   If hGadget
      If StartDrawing(CanvasOutput(#cvsScreen))
         Line  (025,025,350,1, $FF8000)      ;画直线
         Box   (050,050,050,050, $0000E0)    ;矩形
         Circle(175,075,025, $D00000)        ;画圆
         RoundBox(250, 050, 100, 050, 15, 15, $008000)   ;圆角形 
         Ellipse(100, 150, 050, 025, $FF00FF);椭圆形 
         
         DrawingMode(#PB_2DDrawing_Gradient) ;渐变风格
         BackColor ($00FFFF)
         FrontColor($0000FF)
         LinearGradient(250, 125, 350, 125)    
         Box(250, 125, 100, 050)   
         StopDrawing()
      EndIf
   EndIf
   
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; FirstLine = 1
; EnableXP