;***********************************
;迷路仟整理 2019.01.21
;获取控件尺寸
;***********************************

Enumeration
   #winScreen
   #btnScreen
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "获取控件尺寸", WindowFlags)

;产生随机位置的控件
ButtonGadget  (#btnScreen, Random(100, 50), Random(100, 50), Random(200, 100), Random(50, 20), "按键") 

Debug "X = " + GadgetX(#btnScreen)
Debug "Y = " + GadgetY(#btnScreen)
Debug "W = " + GadgetWidth(#btnScreen)
Debug "H = " + GadgetHeight(#btnScreen)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         Debug "EventType = " + Str(GadgetType(GadgetID))
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; Folding = -
; EnableXP