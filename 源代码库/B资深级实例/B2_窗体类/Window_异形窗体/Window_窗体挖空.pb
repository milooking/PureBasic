;***********************************
;迷路仟整理 2019.03.13
;窗体挖空,在窗体中挖去一个区域
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体挖空",  WindowFlags)

*pRgnScreen = CreateRectRgn_(000,000,400,250)  ;新建一个窗体大小的域
*pRgnDigups = CreateRectRgn_(050,050,350,200)  ;新建一个要挖去的域  
CombineRgn_(*pRgnScreen,*pRgnScreen,*pRgnDigups, #RGN_DIFF)  ;两域相减
SetWindowRgn_(hWindow, *pRgnScreen, 1)  
   
Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP