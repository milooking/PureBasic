;***********************************
;迷路仟整理 2019.01.15
;仿程序安装界面
;***********************************

#winScreen1 = 0
#winScreen2 = 1

ScreenW = GetSystemMetrics_(#SM_CXSCREEN)  
ScreenH = GetSystemMetrics_(#SM_CYSCREEN)  

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow1 = OpenWindow(#winScreen1, 0, 0, ScreenW, ScreenH, "背景窗体", #PB_Window_BorderLess)
hWindow2 = OpenWindow(#winScreen2, 0, 0, 400, 250, "前置窗体", WindowFlags, hWindow1)
SetWindowColor(#winScreen1, RGB(128,128,128))
StickyWindow (#winScreen1, #True)

; API方式
; SetWindowPos_(hWindow1, #HWND_TOPMOST,0,0,0,0,#SWP_NOMOVE|#SWP_NOSIZE)  
; SetWindowPos_(hWindow2, #HWND_TOPMOST,0,0,0,0,#SWP_NOMOVE|#SWP_NOSIZE)  
; EnableWindow_(hWindow1, #False)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP