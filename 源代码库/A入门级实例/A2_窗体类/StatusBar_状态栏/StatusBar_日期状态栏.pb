;***********************************
;迷路仟整理 2019.02.02
;StatusBar_日期状态栏
;***********************************

#winScreen = 0
#wsbScreen = 1
#tmrScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "日期状态栏", WindowFlags)
AddWindowTimer(#winScreen, #tmrScreen, 200)

If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(100)
   AddStatusBarField(150)
   AddStatusBarField(130)
   StatusBarText(#wsbScreen,  0, "- PureBasic -", #PB_StatusBar_Center)
   StatusBarText(#wsbScreen,  1, "0000-000-00 00:00:00")
   StatusBarText(#wsbScreen,  2, "提示功能")
EndIf

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case  #PB_Event_Timer 
         If CurrTime <> Date()
            CurrTime = Date()
            StatusBarText(#wsbScreen,  1, FormatDate("%YYYY-%MM-%DD %HH:%II:%SS", CurrTime))
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP