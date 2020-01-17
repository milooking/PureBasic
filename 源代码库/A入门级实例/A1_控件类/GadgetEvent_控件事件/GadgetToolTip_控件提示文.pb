;***********************************
;迷路仟整理 2019.01.21
;控件提示文
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "控件提示文", WindowFlags)

ButtonGadget (#btnScreen1, 10, 15, 230, 30, "启用提示文") 
ButtonGadget (#btnScreen2, 10, 60, 230, 30, "不启用提示文") 

GadgetToolTip(#btnScreen1, "提示文效果")

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