;***********************************
;迷路仟整理 2019.01.21
;解绑控件事件
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration



Procedure EventGadget_Button()
   Debug "当前点击的是控件 #" + EventGadget()
   If EventGadget() = #btnScreen2
      ;使用一次后,解绑
      UnbindGadgetEvent(#btnScreen2, @EventGadget_Button())
   EndIf 
EndProcedure
  
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "解绑控件事件", WindowFlags)

ButtonGadget(#btnScreen1, 10, 10, 180, 30, "按键1")
BindGadgetEvent(#btnScreen1, @EventGadget_Button())

ButtonGadget(#btnScreen2, 10, 50, 180, 30, "按键2")
BindGadgetEvent(#btnScreen2, @EventGadget_Button())


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
; CursorPosition = 20
; Folding = -
; EnableXP