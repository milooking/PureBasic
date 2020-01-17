;***********************************
;迷路仟整理 2019.01.21
;窗体定时器
;***********************************


#winScreen = 0
#prbScreen = 0
#wtrScreen = 123


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
       
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体定时器", WindowFlags)

ProgressBarGadget(#prbScreen, 010, 100, 380, 20, 0, 100)
AddWindowTimer(#winScreen, #wtrScreen, 100)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Timer
         Select EventTimer()
            Case #wtrScreen
               Value + 1
               If Value > 100
                  RemoveWindowTimer(#winScreen, #wtrScreen)
               Else 
                  SetGadgetState(#winScreen, Value)
               EndIf 
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP