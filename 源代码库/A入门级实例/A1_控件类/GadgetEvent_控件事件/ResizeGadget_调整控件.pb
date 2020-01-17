;***********************************
;迷路仟整理 2019.01.21
;调整控件尺寸
;***********************************

Enumeration
   #winScreen
   #btnScreen
EndEnumeration

 
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "调整控件尺寸", WindowFlags)

;产生随机位置的控件
ButtonGadget  (#btnScreen, Random(100, 50), Random(100, 50), Random(200, 100), Random(50, 20), "按键") 
Debug "======Resize前======="
Debug "X = " + GadgetX(#btnScreen)
Debug "Y = " + GadgetY(#btnScreen)
Debug "W = " + GadgetWidth(#btnScreen)
Debug "H = " + GadgetHeight(#btnScreen)

;#PB_Ignore : 表示默认,即采用原来的大小或位置, 
ResizeGadget(#btnScreen, 010, 010, #PB_Ignore, #PB_Ignore)
Debug "======Resize后======="
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
; CursorPosition = 39
; Folding = -
; EnableXP