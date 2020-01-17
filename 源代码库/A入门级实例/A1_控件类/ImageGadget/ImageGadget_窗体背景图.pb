;***********************************
;迷路仟整理 2019.02.08
;窗体背景图
;***********************************
;通过ImageGadget()来设置背景图,万能的容器类背景图设置方法
;注意要对ImageGadget()控件进行DisableGadget()

Enumeration
   #winScreen
   #imgScreen
   #picScreen
   #btnScreen
EndEnumeration

;-

hImage = LoadImage(#imgScreen, "Background.bmp")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "窗体背景图", WindowFlags)

ImageGadget(#picScreen, 000,000,400,250,hImage)
DisableGadget(#picScreen, #True)
ButtonGadget(#btnScreen, 010, 010, 100, 030, "按键1")


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
; CursorPosition = 22
; Folding = -
; EnableXP