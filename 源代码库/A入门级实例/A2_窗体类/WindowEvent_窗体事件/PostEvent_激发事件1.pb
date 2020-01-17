;***********************************
;迷路仟整理 2019.01.21
;激发事件1
;***********************************

Enumeration 
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "激发事件1", WindowFlags)
ButtonGadget(#btnScreen1, 150, 050, 100, 040, "按键1")
ButtonGadget(#btnScreen2, 150, 100, 100, 040, "按键2")
ButtonGadget(#btnScreen3, 150, 150, 100, 040, "按键3")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         Select EventGadget() 
            Case #btnScreen1 : Debug "点击[按键1],并激发<点击[按键2]>"
               PostEvent(#PB_Event_Gadget, #winScreen, #btnScreen2)
            Case #btnScreen2 : Debug "点击[按键2]"
            Case #btnScreen3 : Debug "点击[按键3]"
         EndSelect
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; Folding = -
; EnableXP