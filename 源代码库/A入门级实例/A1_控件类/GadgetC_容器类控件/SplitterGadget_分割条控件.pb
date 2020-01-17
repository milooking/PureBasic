;***********************************
;迷路仟整理 2019.01.20
;分割条控件
;***********************************

Enumeration
   #winScreen
   #rtxScreen1
   #rtxScreen2
   #splScreen

EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "分割条控件", WindowFlags)

EditorGadget (#rtxScreen1, 0, 0, 0, 0) ; 投入分割条控件后,会自动调整控件尺寸和位置
EditorGadget (#rtxScreen2, 0, 0, 0, 0) 
SplitterGadget(#splScreen, 10, 10, 380, 230, #rtxScreen1, #rtxScreen2, #PB_Splitter_Separator)
SetGadgetState(#splScreen, 50)

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
; CursorPosition = 7
; Folding = -
; EnableXP