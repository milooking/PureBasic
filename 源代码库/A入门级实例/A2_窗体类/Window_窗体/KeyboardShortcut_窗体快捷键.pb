;***********************************
;迷路仟整理 2019.01.21
;窗体快捷键
;***********************************


#winScreen = 0
#lblScreen = 0

;AddKeyboardShortcut()快捷键使用的响应事件是EventMenu()菜单事件.

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
       
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体快捷键", WindowFlags)
TextGadget(#lblScreen, 130, 100, 140, 060, "按[F1]响应[事件11], "+#LF$+"按[F2]响应[事件12],"+#LF$+"并删除[F2]快捷键")

AddKeyboardShortcut(#winScreen, #PB_Shortcut_F1, 11)
AddKeyboardShortcut(#winScreen, #PB_Shortcut_F2, 12)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu
         Select EventMenu()
            Case 11 : Debug "事件11"
            Case 12 : RemoveKeyboardShortcut(#winScreen, #PB_Shortcut_F2) : Debug "删除事件12" 
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; EnableXP