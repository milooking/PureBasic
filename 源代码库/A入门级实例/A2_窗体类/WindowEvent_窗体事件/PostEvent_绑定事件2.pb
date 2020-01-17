;***********************************
;迷路仟整理 2019.01.21
;绑定事件2
;***********************************

Enumeration 
   #winScreen
EndEnumeration

Procedure Event_SizeWindow()
   WindowID = EventWindow()
   Debug "WindowW = " + WindowWidth(WindowID) + " : WindowH = " + WindowHeight(WindowID)
EndProcedure



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "绑定事件2-绑定窗体", WindowFlags)

WindowID = OpenWindow(#PB_Any, 0, 0, 250, 150, "子窗体", WindowFlags, hWindow)

BindEvent(#PB_Event_SizeWindow, @Event_SizeWindow(), WindowID) ;只绑定子窗体事件

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
      Case #PB_Event_SizeWindow  ; 虽然这里没有代码,但因为有BindEvent()了#PB_Event_SizeWindow,所以依然有响应事件
      Case #PB_Event_Gadget
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 24
; Folding = -
; EnableXP