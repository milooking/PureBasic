;***********************************
;迷路仟整理 2019.01.15
;改变窗体标题
;***********************************


#winScreen = 0
#btnScreen = 1

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "改变窗体标题", WindowFlags)

ButtonGadget(#btnScreen,010,010,100,030,"改变窗体标题") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            Index+1
            SetWindowTitle(#winScreen, "新的窗体标题-"+Str(Index))
            Debug GetWindowTitle(#winScreen)
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; EnableXP