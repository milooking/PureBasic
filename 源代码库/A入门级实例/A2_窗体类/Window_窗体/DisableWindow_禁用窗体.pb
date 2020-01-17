;***********************************
;迷路仟整理 2019.01.21
;禁用/启用窗体
;***********************************

#winScreen = 0
#btnScreen = 1


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "禁用/启用窗体", WindowFlags)
ButtonGadget(#btnScreen, 150, 200, 100, 040, "禁用子窗体", #PB_Button_Toggle)

WindowID = OpenWindow(#PB_Any, 0, 0, 250, 050, "子窗体", WindowFlags, hWindow)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow 
         WindowID = EventWindow()
         If WindowID = #winScreen
            IsExitWindow = #True
         Else 
            CloseWindow(WindowID)
         EndIf 
      
      Case #PB_Event_Gadget
         If EventGadget() = #btnScreen
            If IsWindow(WindowID) = 0
               WindowID = OpenWindow(#PB_Any, 0, 0, 250, 050, "子窗体", WindowFlags, hWindow)
            EndIf 
            
            If GetGadgetState(#btnScreen)
               SetGadgetText(#btnScreen, "启用子窗体")
               DisableWindow(WindowID, #True) 
            Else 
               SetGadgetText(#btnScreen, "禁用子窗体")
               DisableWindow(WindowID, #False) 
            EndIf 
         EndIf 
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 12
; EnableXP