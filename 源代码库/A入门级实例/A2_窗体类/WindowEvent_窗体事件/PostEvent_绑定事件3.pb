;***********************************
;迷路仟整理 2019.01.21
;绑定事件3
;***********************************

Enumeration 
   #winScreen
EndEnumeration

Procedure Window_EventGadget()
   Debug "GadgetID = " + EventGadget()
EndProcedure



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "绑定事件3-绑定控件", WindowFlags)
ButtonID = ButtonGadget(#PB_Any, 010, 010, 100, 030, "按键")
Debug "GadgetID = " + ButtonID

WindowID = OpenWindow(#PB_Any, 0, 0, 250, 150, "子窗体", WindowFlags, hWindow)
ButtonID = ButtonGadget(#PB_Any, 010, 010, 100, 030, "按键")
Debug "GadgetID = " + ButtonID

;只绑定子窗体并绑定指定控件事件,相当于BindGadgetEvent()

BindEvent(#PB_Event_Gadget, @Window_EventGadget(), WindowID, ButtonID, #PB_EventType_LeftClick) 

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
; CursorPosition = 6
; Folding = -
; EnableXP