;***********************************
;迷路仟整理 2019.01.20
;滚动域控件
;***********************************

Enumeration
   #winScreen
   #scrScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #lblScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "滚动域控件", WindowFlags)

ScrollAreaGadget(#scrScreen,   010, 010, 380, 230, 375, 355, 30, #PB_ScrollArea_Center)
   ButtonGadget  (#btnScreen1, 010, 010, 230, 030,"按键1")
   ButtonGadget  (#btnScreen2, 050, 050, 230, 030,"按键2")
   ButtonGadget  (#btnScreen3, 090, 090, 230, 030,"按键3")
   TextGadget    (#lblScreen,  130, 130, 230, 020,"这些都是滚动域控件内的控件!",#PB_Text_Right)
CloseGadgetList()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 24
; Folding = -
; EnableXP