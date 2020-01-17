;***********************************
;迷路仟整理 2019.01.15
;状态栏进度条
;***********************************

#winScreen = 0
#wsbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "状态栏进度条", WindowFlags)

If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(100)
   AddStatusBarField(200)
EndIf

StatusBarText(#wsbScreen, 0, "进度度")
StatusBarProgress(#wsbScreen, 1, 100, 0, 0, 100)
AddWindowTimer(#winScreen, 123, 100)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Timer 
         If EventTimer() = 123 And Index <= 100
            StatusBarProgress(#wsbScreen, 1, Index)
            Index+1
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP