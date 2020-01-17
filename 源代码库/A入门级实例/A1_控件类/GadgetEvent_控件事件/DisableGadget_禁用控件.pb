;***********************************
;迷路仟整理 2019.01.21
;禁用控件
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "禁用控件", WindowFlags)

ButtonGadget (#btnScreen1, 10, 15, 230, 30, "禁用状态") 
DisableGadget(#btnScreen1, #True)
ButtonGadget (#btnScreen2, 10, 60, 230, 30, "启用状态") 
DisableGadget(#btnScreen2, #False)

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
; CursorPosition = 15
; Folding = -
; EnableXP