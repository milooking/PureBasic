;***********************************
;迷路仟整理 2019.02.08
;分页控件背景图
;***********************************
;通过ImageGadget()来设置背景图,万能的容器类背景图设置方法
;注意要对ImageGadget()控件进行DisableGadget()

Enumeration
   #winScreen
   #pnlScreen
   #imgScreen
   #picScreen1
   #picScreen2
   #btnScreen1
   #btnScreen2
EndEnumeration


;-
hImage = LoadImage(#imgScreen, "Background.bmp")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "分页控件背景图", WindowFlags)
PanelGadget(#pnlScreen, 010, 010, 380, 230)                                        
   AddGadgetItem(1, -1, "分页-1")
      ImageGadget(#picScreen1, 000,000,400,250,hImage)
      DisableGadget(#picScreen1, #True)
      ButtonGadget(#btnScreen1, 010, 010, 100, 030, "按键1")
   AddGadgetItem(1, -1, "分页-2")
      ImageGadget(#picScreen2, 000,000,400,250,hImage)
      DisableGadget(#picScreen2, #True)
      ButtonGadget(#btnScreen2, 010, 010, 100, 030, "按键2")
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
; CursorPosition = 6
; Folding = -
; EnableXP