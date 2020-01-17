;***********************************
;迷路仟整理 2019.01.15
;修改窗体图标
;***********************************

#winScreen = 0
#btnScreen = 1
#imgScreen = 2


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "改变窗体图标", WindowFlags)

ButtonGadget(#btnScreen,010,010,100,030,"修改窗体图标") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            If LoadImage(#imgScreen,"PureBasic.ico") 
               SendMessage_(hWindow, #WM_SETICON, #False, ImageID(#imgScreen)) 
            EndIf 
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP