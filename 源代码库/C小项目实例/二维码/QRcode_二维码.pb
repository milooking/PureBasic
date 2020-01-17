;***********************************
;迷路仟整理 2017.08.09
;生成二维码
;***********************************

#MQR_ECLEVEL_L = 0 ; lowest
#MQR_ECLEVEL_M = 1
#MQR_ECLEVEL_Q = 2
#MQR_ECLEVEL_H = 3 ; highest

Structure __QRImageInfo
   Version.l
   Width.l
   *pSymbolData
EndStructure

Import "bufferoverflowu.lib"
  __security_init_cookie() As "___security_init_cookie"
EndImport

ImportC "libqrencode.lib"
   QRcode_encodeString8bit(Text.p-ascii, Version.l, QRecLevel.l) As "_QRcode_encodeString8bit"
   QRcode_free(*pQrcode.__QRImageInfo) As "_QRcode_free"
EndImport

Procedure CreateQRImage(ImageID, Content$, QRecLevel=#MQR_ECLEVEL_M, ZoomSize=0)
   *pQrcode.__QRImageInfo = QRcode_encodeString8bit(Content$, 0, QRecLevel)
   If *pQrcode And *pQrcode\Width > 0
      Result = CreateImage(ImageID, *pQrcode\Width, *pQrcode\Width, 24)
      If ImageID = #PB_Any : ImageID = Result : EndIf 
      If Result > 0 And StartDrawing(ImageOutput(ImageID))
         For y = 0 To *pQrcode\Width - 1
            For x = 0 To *pQrcode\Width - 1
               If PeekB(*pQrcode\pSymbolData+k) & $1 =0
                  Plot(x, y, $FFFFFF)
               EndIf 
               k + 1
            Next   
         Next
         StopDrawing()
      EndIf
      QRcode_free(*pQrcode)  
      If ZoomSize > 0 
         ResizeImage(ImageID, ZoomSize, ZoomSize, #PB_Image_Raw)
      EndIf 
      ProcedureReturn Result
   EndIf
   ProcedureReturn 0
EndProcedure

#winScreen = 0
#imgScreen = 1
WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 220, 220, "生成二维码",  WindowFlags)
CreateQRImage(#imgScreen, "欢迎使用[迷路PureBasic实例库工具]", #MQR_ECLEVEL_M, 200)
ImageGadget(#imgScreen, 10, 10, 200, 200, ImageID(#imgScreen))

Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 46
; FirstLine = 13
; Folding = 9
; EnableXP
; EnableUnicode