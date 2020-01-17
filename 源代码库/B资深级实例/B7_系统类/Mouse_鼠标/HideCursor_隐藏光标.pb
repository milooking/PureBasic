;***********************************
;迷路仟整理 2019.02.01
;HideCursor_隐藏光标
;***********************************

#winScreen = 0
#btnScreen = 0


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "隐藏光标", WindowFlags)
ButtonGadget(#btnScreen, 150, 100, 100, 030, "隐藏光标")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         Select EventGadget()
            Case #btnScreen
               Debug "隐藏光标: 3秒后恢复正常!"
               SetGadgetText(#btnScreen, "3秒后恢复!")
               ShowCursor_(#False)
               Delay(1000)
               SetGadgetText(#btnScreen, "2秒后恢复!")
               Delay(1000)
               SetGadgetText(#btnScreen, "1秒后恢复!")
               Delay(1000)
               ShowCursor_(#True) 
               SetGadgetText(#btnScreen, "隐藏光标!")
               Debug "恢复正常!"
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
ShowCursor_(#True) 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; EnableXP
; EnableOnError