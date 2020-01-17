;***********************************
;迷路仟整理 2019.01.16
;图像按键
;***********************************

Enumeration
   #WinScreen
   #btnScreen1
   #btnScreen2
   #imgScreen1
   #imgScreen2
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 250, "图像按键", WindowFlags)

hImage1 = LoadImage(#imgScreen1, "Forums.ico")
ButtonImageGadget(#btnScreen1, 150, 050, 050, 50, hImage1)

hImage2 = LoadImage(#imgScreen2, "PureBasic.ico")
ButtonImageGadget(#btnScreen2, 220, 050, 050, 50, hImage2)
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; FirstLine = 3
; Folding = -
; EnableXP