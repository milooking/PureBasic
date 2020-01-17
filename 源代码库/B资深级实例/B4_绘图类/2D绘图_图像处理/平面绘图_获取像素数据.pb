;***********************************
;迷路仟整理 2019.06.24
;平面绘图_获取像素数据
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #chkAlphaR
   #chkAlphaG
   #chkAlphaB
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "平面绘图_获取像素数据", WindowFlags)

hImage = LoadImage(#imgScreen, "..\Background.bmp")
hImageDC = StartDrawing(ImageOutput(#imgScreen))
If hImageDC
   ImageW = ImageWidth (#imgScreen)
   ImageH = ImageHeight(#imgScreen)
   DataSize = (ImageW + 4-1)/4*4       ;做字节对齐处理，RGB(RGB16与RGB24)之必须，
   DataSize = ImageH * DataSize * 3
   *MemTemp =  AllocateMemory(DataSize)  
   ; 设置BMP图像的头部信息
   BmpData.BITMAPINFOHeader
   BmpData\biSize            = SizeOf(BITMAPINFOHeader)  
   BmpData\biWidth           =  ImageW  
   BmpData\biHeight          =  -ImageH      ;负数表示图像按从上到下的顺序列,正数表示反序
   BmpData\biPlanes          =  1  
   BmpData\biBitCount        =  24           ;24:R8G8B8, 32:R8G8B8X8
   BmpData\biCompression     =  #BI_RGB
   GetDIBits_(hImageDC, hImage, 0, ImageH, *MemTemp, @BmpData, #DIB_RGB_COLORS)  
   ;*MemTemp内存块里面放的就是像素数据
   Debug "读取像素流成功!"
   StopDrawing()
EndIf  

ImageGadget(#cvsScreen, 000, 000, 400, 250, hImage)


Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
FreeImage(#imgScreen)
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; FirstLine = 18
; Folding = -
; EnableXP
; EnableUnicode