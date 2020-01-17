;***********************************
;迷路仟整理 2019.01.15
;状态栏实例2
;***********************************

#winScreen = 0
#wsbScreen = 0
#frnScreen = 0
#imgScreen = 0
#SB_SETICON=(#WM_USER) +15 

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "状态栏实例2", WindowFlags)


LoadImage(#imgScreen, "PureBasic.ico")
LoadFont(#frnScreen, "", 14, #PB_Font_Bold)

If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(130)
   AddStatusBarField(130)
   AddStatusBarField(130)
   StatusBarText(#wsbScreen,  0, "修改字体")
   StatusBarText(#wsbScreen,  1, "带自图标")
   StatusBarImage(#wsbScreen, 1, ImageID(#imgScreen))
   StatusBarText(#wsbScreen,  2, "带自图标")
EndIf
SendMessage_(StatusBarID(#wsbScreen), #WM_SETFONT, FontID(#frnScreen), #True) 
SendMessage_(StatusBarID(#wsbScreen), #SB_SETICON, 2, ImageID(#imgScreen)) 

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
; CursorPosition = 4
; EnableXP