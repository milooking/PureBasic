;***********************************
;迷路仟整理 2019.01.23
;ImagePlugin_图像插件
;***********************************


;图像插件分解码器和编码器两种,使用不同的图像,要启不用同的解码器或编码器
;启用不同的解码器或编码器,会影响编译后EXE或DLL的大小.
;解码器有: 
UseGIFImageDecoder()
UseJPEG2000ImageDecoder()
UseJPEGImageDecoder()
UsePNGImageDecoder()
UseTGAImageDecoder()
UseTIFFImageDecoder()

;编码器有: 
UseJPEG2000ImageEncoder()
UseJPEGImageEncoder()
UsePNGImageEncoder()

Enumeration
   #winScreen
   #wtbScreen
   #imgScreen1
   #imgScreen2
   #imgScreen3
   #picScreen

EndEnumeration


hWindow = OpenWindow(#winScreen, 0, 0, 400, 200, "ImagePlugin_图像插件", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CreateToolBar(#wtbScreen, hWindow)
      ToolBarImageButton(0, LoadImage(#imgScreen1, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Open.png"))
      ToolBarImageButton(1, LoadImage(#imgScreen2, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Save.png"))
    DisableToolBarButton(#wtbScreen, 1, 1) 
    
  ImageGadget(#picScreen, 0, 28, WindowWidth(#winScreen), WindowHeight(#winScreen), 0, #PB_Image_Border)
  
Repeat
   WinEvent = WaitWindowEvent() 
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu
         Select EventMenu()
            Case 0  ;打开
               FileName$ = OpenFileRequester("请选译图片", "", "任意图像|*.bmp;*.jpg;*.png;*.tif;*.tga;*.gif", 0)
               If FileName$
                  If UCase(GetExtensionPart(Filename$)) = "GIF"
                     MessageRequester("关于GIF", "请参考'ImagePlugin_GIF.pb' ")
                  EndIf
                  If LoadImage(#imgScreen3, Filename$)
                     SetGadgetState(#picScreen, ImageID(#imgScreen3))
                     DisableToolBarButton(#wtbScreen, 1, 0)    ;启用保存功能
                     ResizeWindow(#winScreen, #PB_Ignore, #PB_Ignore, ImageWidth(#imgScreen3)+4, ImageHeight(#imgScreen3)+34)
                  EndIf
               EndIf
            Case 1  ;关闭
               ImageName$ = Left(FileName$, Len(FileName$)-Len(GetExtensionPart(FileName$))-1)
               FileName$ = SaveFileRequester("保存图片", ImageName$, "BMP 格式|*.bmp|JPEG 格式|*.jpg|PNG 格式|*.png", 0)
               If FileName$
                  Select SelectedFilePattern()
                    Case 0  ; BMP
                      ImageFormat = #PB_ImagePlugin_BMP
                      Extension$  = "bmp"
                    Case 1  ; JPEG
                      ImageFormat = #PB_ImagePlugin_JPEG
                      Extension$  = "jpg"
                    Case 2  ; PNG
                      ImageFormat = #PB_ImagePlugin_PNG
                      Extension$  = "png"
                  EndSelect
                  If LCase(GetExtensionPart(FileName$)) <> Extension$
                    FileName$ + "." + Extension$
                  EndIf
                  
                  If SaveImage(#imgScreen3, FileName$, ImageFormat)
                     MessageRequester("提示", "保存图像成功!", 0)
                  EndIf
               EndIf 
         EndSelect
         
   EndSelect    
Until IsExitWindow = #True

FreeImage(#imgScreen1)   ;注销图像
FreeImage(#imgScreen2)
If IsImage(#imgScreen3) : FreeImage(#imgScreen3) : EndIf ;判断图像是否存在,再注销
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 43
; FirstLine = 27
; Folding = -
; EnableXP