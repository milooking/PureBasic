;***********************************
;迷路仟整理 2017.07.15
;设置窗体的背景图像
;***********************************

#winScreen = 0     
#imgScreen = 0     

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow= OpenWindow(#winScreen,WindowW,WindowH, 400, 250,"窗体背景图像", WindowFlags) 
hImage = LoadImage(#imgScreen, "Background.bmp")
hBackImage= CreatePatternBrush_(hImage)
If hBackImage
   SetClassLongPtr_(hWindow, #GCL_HBRBACKGROUND, hBackImage)
   RedrawWindow_(hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
EndIf 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True
DeleteObject_(hBackImage)  


End 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; EnableXP