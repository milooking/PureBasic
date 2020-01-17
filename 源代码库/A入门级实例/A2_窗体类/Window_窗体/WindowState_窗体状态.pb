;***********************************
;迷路仟整理 2019.01.21
;窗体状态
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体状态", WindowFlags)

ButtonGadget(#btnScreen1, 150, 050, 100, 040, "正常化")
ButtonGadget(#btnScreen2, 150, 100, 100, 040, "最大化")
ButtonGadget(#btnScreen3, 150, 150, 100, 040, "最小化")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      
      Case #PB_Event_Gadget
         Select EventGadget() 
            Case #btnScreen1 : SetWindowState(#winScreen, #PB_Window_Normal) 
            Case #btnScreen2 : SetWindowState(#winScreen, #PB_Window_Maximize) 
            Case #btnScreen3 : SetWindowState(#winScreen, #PB_Window_Minimize) 
         EndSelect
         Debug "WindowState = 0x" + Hex(GetWindowState(#winScreen))
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP