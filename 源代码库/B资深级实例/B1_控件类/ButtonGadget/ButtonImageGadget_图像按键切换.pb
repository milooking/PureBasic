;***********************************
;迷路仟整理 2019.01.17
;图像按键切换
;***********************************

Enumeration
   #WinScreen
   #btnScreen
   #imgScreen1
   #imgScreen2
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 250, "图像按键切换", WindowFlags)

hImage1 = LoadImage(#imgScreen1, "Forums.ico")
hImage2 = LoadImage(#imgScreen2, "PureBasic.ico")

ButtonImageGadget(#btnScreen, 150, 050, 050, 50, hImage1, #PB_Button_Toggle)

SetGadgetAttribute(#btnScreen, #PB_Button_PressedImage, hImage2)
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP