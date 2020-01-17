;***********************************
;迷路仟整理 2019.01.21
;置顶窗体
;***********************************

#winScreen = 0
#btnScreen = 1


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "置顶窗体", WindowFlags)
ButtonGadget(#btnScreen, 150, 200, 100, 040, "置顶窗体", #PB_Button_Toggle)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      
      Case #PB_Event_Gadget
         If EventGadget() = #btnScreen
            State = GetGadgetState(#btnScreen)
            StickyWindow(#winScreen, State) 
         EndIf 
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; EnableXP