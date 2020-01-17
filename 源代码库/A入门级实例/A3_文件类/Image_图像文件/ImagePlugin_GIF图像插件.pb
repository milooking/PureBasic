;***********************************
;迷路仟整理 2019.01.23
;ImagePlugin_GIF图像插件
;***********************************


;使用GIF解码器
UseGIFImageDecoder()


Enumeration
   #winScreen
   #cvsScreen
   #wtrScreen
   #imgScreen
EndEnumeration


LoadImage(#imgScreen, #PB_Compiler_Home+"Examples/Sources/Data/PureBasicLogo.gif")
If IsImage(#imgScreen) = 0
   MessageRequester("出错", "./Examples/Sources/Data/PureBasicLogo.gif 图像不存在")
   End ;结束程序
EndIf 
ImageW = ImageWidth(#imgScreen)
ImageH = ImageHeight(#imgScreen)
hWindow = OpenWindow(#winScreen, 0, 0, ImageW, ImageH, "ImagePlugin_GIF图像插件", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 0, 0, ImageW, ImageH)
   AddWindowTimer(#winScreen, #wtrScreen, 10) 
   
Repeat
   WinEvent = WaitWindowEvent() 
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Timer
      
         ;设置帧
         SetImageFrame(#imgScreen, Frame)
         
         ;重新定义计时器,按帧间隔时间来处理
         RemoveWindowTimer(#winScreen, #wtrScreen)
         AddWindowTimer(#winScreen, #wtrScreen, GetImageFrameDelay(#imgScreen))
        
         ;绘制帧图像
         If StartDrawing(CanvasOutput(#cvsScreen))
            DrawImage(ImageID(#imgScreen), 0, 0)
            StopDrawing()
         EndIf
         
         ;获取下一帧
         Frame+1
         ;判断是否需要循环帧
         If Frame >= ImageFrameCount(#imgScreen) : Frame = 0 : EndIf
         
   EndSelect    
Until IsExitWindow = #True

FreeImage(#imgScreen) ;注销图像
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP