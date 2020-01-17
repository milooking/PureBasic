;***********************************
;迷路仟整理 2019.01.15
;闪动窗体
;***********************************

#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "闪动窗体", WindowFlags)

Info.FLASHWINFO  
Info\cbSize = SizeOf(FLASHWINFO)  
Info\hwnd   = hWindow  
Info\dwFlags= $7;#FLASHW_ALL  
Info\uCount = 0  
Info\dwTimeout = 200  
FlashWindowEx_(Info)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP