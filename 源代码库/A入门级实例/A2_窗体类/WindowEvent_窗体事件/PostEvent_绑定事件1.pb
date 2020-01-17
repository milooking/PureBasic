;***********************************
;迷路仟整理 2019.01.21
;绑定事件1
;***********************************

Enumeration 
   #winScreen
   #lstScreen
EndEnumeration

Procedure Event_SizeWindow()
   W = WindowWidth(#winScreen)
   H = WindowHeight(#winScreen)
   ResizeGadget(#lstScreen, #PB_Ignore, #PB_Ignore, W-20, H-20)
EndProcedure

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "绑定事件1", WindowFlags)

ListIconGadget(#lstScreen,  010, 010, 380, 230, "列-1", 400-45-120, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_CheckBoxes)
For Col = 2 To 4 
   AddGadgetColumn(#lstScreen, Col, "列-" + Str(Col), 60)
Next
For Row = 0 To 10
   AddGadgetItem(#lstScreen, Row, "子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row)+Chr(10)+"子项-"+Str(Row))
Next

SetGadgetState(#lstScreen, 5)

BindEvent(#PB_Event_SizeWindow, @Event_SizeWindow())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow  ; 虽然这里没有代码,但因为有BindEvent()了#PB_Event_SizeWindow,所以依然有响应事件
      Case #PB_Event_Gadget
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; Folding = -
; EnableXP