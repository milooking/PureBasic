;***********************************
;迷路仟整理 2019.01.26
;MousetWheel_鼠标中轮事件
;***********************************


#winScreen = 0
#lblScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
       
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标中轮事件", WindowFlags)
TextGadget(#lblScreen, 130, 100, 140, 060, "")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MBUTTONDBLCLK
         SetGadgetText(#lblScreen, "中轮双击") : Debug "中轮双击"   
      Case #WM_MBUTTONDOWN
         SetGadgetText(#lblScreen, "中轮按下") : Debug "中轮按下"   
      Case #WM_MBUTTONUP
         SetGadgetText(#lblScreen, "中轮弹起") : Debug "中轮弹起"   
      Case #WM_MOUSEWHEEL
         Scroll.w = ((EventwParam()>>16) & $FFFF)
         Scroll = - Scroll / 120
         Select Scroll
            Case -1 : SetGadgetText(#lblScreen, "中轮上滚") : Debug "中轮上滚: " + Scroll
            Case 01 : SetGadgetText(#lblScreen, "中轮下滚") : Debug "中轮下滚: " + Scroll
         EndSelect 
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; EnableXP
; EnableOnError