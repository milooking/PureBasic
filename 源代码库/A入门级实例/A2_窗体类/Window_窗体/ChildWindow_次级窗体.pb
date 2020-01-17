;***********************************
;迷路仟整理 2019.01.15
;次级窗体演示
;***********************************


#winScreen = 0
#btnScreen = 0
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "次级窗体演示", WindowFlags)

ButtonGadget(#btnScreen, 150, 110, 100, 030, "生成新窗体")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow 
         WindowID = EventWindow()
         If WindowID = #winScreen
            IsExitWindow = #True    ;主窗体关闭
         Else 
            CloseWindow(WindowID)   ;次级窗体关闭
         EndIf 
      Case #PB_Event_Gadget
         If EventGadget() = #btnScreen
            Index+1
            WindowFlags = #PB_Window_WindowCentered| #PB_Window_MinimizeGadget|#PB_Window_SystemMenu
            OpenWindow(#PB_Any, 0, 0, 200, 120, "次级窗体-"+Str(Index), WindowFlags, hWindow)
            TextGadget(#PB_Any, 010, 010, 100, 020, "次级窗体-"+Str(Index))
         EndIf 
   EndSelect
   
   Delay(1)
Until IsExitWindow = #True
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; EnableXP