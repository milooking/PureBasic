;***********************************
;迷路仟整理 2019.01.21
;隐藏控件
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "隐藏控件", WindowFlags)

hButton1 = ButtonGadget(#btnScreen1, 010, 010, 150, 025, "按键1", #PB_Button_Toggle)
hButton2 = ButtonGadget(#btnScreen2, 010, 040, 150, 025, "按键2", #PB_Button_Toggle)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #btnScreen1
               State = GetGadgetState(#btnScreen1)
               HideGadget(#btnScreen2, State)
            Case #btnScreen2
               State = GetGadgetState(#btnScreen2)
               HideGadget(#btnScreen1, State)
        EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = -
; EnableXP