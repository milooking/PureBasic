;***********************************
;迷路仟整理 2019.01.18
;图像控件
;***********************************

Enumeration
   #WinScreen
   #picScreen1
   #picScreen2
   #picScreen3
   #imgScreen1
   #imgScreen2
EndEnumeration

UsePNGImageDecoder()
LoadImage(#imgScreen1, "PureBasic.png")
LoadImage(#imgScreen2, "PureBasic.bmp")

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 500, 250, "图像控件", WindowFlags)

;注意:
;1.ImageGadget()的大小由图像的大小决定,即自动大小,没有图像是,大小有意义.
;2.ImageGadget()支持透明效果.
;3.ImageGadget()在CanvasGadget():CloseGadgetList()中无效,应当是个BUG.
;4.ImageGadget()的透明效果,可以用它来做更多特效操作.

ImageGadget(#picScreen1, 020, 050, 000, 000, ImageID(#imgScreen1))
ImageGadget(#picScreen2, 180, 050, 000, 000, ImageID(#imgScreen2), #PB_Image_Border)  
ImageGadget(#picScreen3, 320, 050, 100, 100, 0, #WS_EX_DLGMODALFRAME)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; FirstLine = 9
; Folding = -
; EnableXP