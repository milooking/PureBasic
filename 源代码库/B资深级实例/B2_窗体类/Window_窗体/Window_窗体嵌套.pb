;***********************************
;迷路仟整理 2019.01.15
;窗体嵌套
;***********************************

; 窗体嵌套演示
Enumeration
   #winScreen
   #winChild1
   #winChild2
EndEnumeration

ChildFlags = #WS_POPUP | #WS_SYSMENU
hWindowP = OpenWindow(#winScreen, 0, 0, 500, 300, "窗体嵌套", #PB_Window_ScreenCentered | #PB_Window_SystemMenu)
GetClientRect_(hWindowP, @ParentArea.RECT)

hWindow1 = OpenWindow(#winChild1, ParentArea\left, ParentArea\top+000, 500, 150, "嵌套窗体 - 1", #WS_CHILD, hWindowP) 
TextGadget  (11,10,10,100,15,"按键1:")
ButtonGadget(12,10,35,100,30,"按键1:")

hWindow2 = OpenWindow(#winChild2, ParentArea\left, ParentArea\top+150, 500, 150, "嵌套窗体 - 2", #WS_CHILD, hWindowP) 
TextGadget  (21,10,10,100,15,"按键2:")
ButtonGadget(22,10,35,100,30,"按键2:")

Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; Folding = -
; EnableXP