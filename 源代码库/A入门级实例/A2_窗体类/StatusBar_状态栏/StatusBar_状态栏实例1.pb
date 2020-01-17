;***********************************
;迷路仟整理 2019.01.15
;状态栏实例1
;***********************************


#winScreen = 0
#wsbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "状态栏实例1", WindowFlags)

If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(100)
   AddStatusBarField(100)
   AddStatusBarField(100)
   AddStatusBarField(100)
EndIf

StatusBarText(#wsbScreen, 0, "左对齐文本")
StatusBarText(#wsbScreen, 1, "无边框", #PB_StatusBar_BorderLess)
StatusBarText(#wsbScreen, 2, "居中文本", #PB_StatusBar_Center)
StatusBarText(#wsbScreen, 3, "右对齐文本", #PB_StatusBar_Right | #PB_StatusBar_Raised) 


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case  #PB_Event_Timer 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableXP