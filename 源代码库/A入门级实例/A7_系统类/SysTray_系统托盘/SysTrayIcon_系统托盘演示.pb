;***********************************
;迷路仟整理 2019.01.15
;SysTrayIcon_系统托盘演示
;***********************************

Enumeration
   #winScreen
   #stiScreen
   #imgScreen1
   #imgScreen2
EndEnumeration

hImage1 = LoadImage(#imgScreen1, "PureBasic.ico")
hImage2 = LoadImage(#imgScreen2, "Tailbite.ico")

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "系统托盘演示: 注意桌面右下角", WindowFlags)

AddSysTrayIcon(#stiScreen, hWindow, hImage1)
SysTrayIconToolTip(#stiScreen, "系统托盘演示:PB")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SysTray
         If EventType() = #PB_EventType_LeftClick
            State = 1-State
            If State
               ChangeSysTrayIcon(#stiScreen, hImage2)
               SysTrayIconToolTip(#stiScreen, "系统托盘PB: 点击可以切换")
            Else 
               ChangeSysTrayIcon(#stiScreen, hImage1)
               SysTrayIconToolTip(#stiScreen, "系统托盘TB: 点击可以切换")
            EndIf 
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = -
; EnableXP