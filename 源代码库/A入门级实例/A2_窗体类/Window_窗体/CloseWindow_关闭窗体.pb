;***********************************
;迷路仟整理 2019.01.21
;窗体跟随
;***********************************

#winScreen = 0
#btnScreen = 1


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "主窗体", WindowFlags)

ButtonGadget(#btnScreen, 150, 100, 100, 050, "生成子窗体")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow       
         WindowID = EventWindow()
         If WindowID = #winScreen
            IsExitWindow = #True
         Else 
            CloseWindow(WindowID)
         EndIf 
      Case #PB_Event_Gadget
         If EventGadget() = #btnScreen
            OpenWindow(#PB_Any, 0, 0, 350, 250, "子窗体: 关闭子窗体,不影响父窗体", WindowFlags, hWindow)
         EndIf 
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; EnableXP