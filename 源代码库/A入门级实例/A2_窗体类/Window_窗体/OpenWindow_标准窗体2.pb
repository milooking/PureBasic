;***********************************
;迷路仟整理 2019.01.15
;标准窗体生成实例
;***********************************

;-
Enumeration 
   #winScreen
EndEnumeration
;-
; 创建菜单栏
Procedure Screen_CreateMenu(WindowID)

EndProcedure

; 创建工具栏
Procedure Screen_CreateToolBar(WindowID)

EndProcedure

; 创建状态栏
Procedure Screen_CreateStatusBar(WindowID)

EndProcedure

; 创建控件
Procedure Screen_CreateGadget(WindowID)
   Screen_CreateMenu     (WindowID)
   Screen_CreateToolBar  (WindowID)
   Screen_CreateStatusBar(WindowID)
EndProcedure

;-
; 调整窗体
Procedure Screen_ResizeWindow(WindowID)

EndProcedure

; 单个控件事件
Procedure Screen_Gadget_EventType(EventType)
   Select EventType
      Case #PB_EventType_LeftClick
      Case #PB_EventType_RightClick
      Case #PB_EventType_LeftDoubleClick
      Case #PB_EventType_RightDoubleClick
      Case #PB_EventType_Focus
      Case #PB_EventType_LostFocus
      Case #PB_EventType_Change
      Case #PB_EventType_DragStart
   EndSelect
EndProcedure


; 控件事件
Procedure Screen_EventGadget(GadgetID, EventType)
   Select EventType
      Case #Null : IsExitWindow = Screen_Gadget_EventType(EventType)
   EndSelect
EndProcedure

;-
; 主程序部分
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "标准窗体", WindowFlags)
Screen_CreateGadget(WindowID)

Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow  : Screen_ResizeWindow(WindowID)
      Case #PB_Event_Gadget      : Screen_EventGadget(GadgetID, EventType)
      Case #WM_LBUTTONDOWN
      Case #WM_MOUSEMOVE
      Case #WM_LBUTTONUP
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; FirstLine = 51
; Folding = --
; EnableXP