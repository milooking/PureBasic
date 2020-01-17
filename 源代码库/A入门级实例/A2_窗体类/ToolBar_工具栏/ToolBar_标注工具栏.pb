;***********************************
;迷路仟整理 2019.01.15
;标注工具栏
;***********************************

#winScreen = 0
#wtbScreen = 0
#btnScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "标注工具栏", WindowFlags)

If CreateToolBar(#wtbScreen, WindowID(0), #PB_ToolBar_Large | #PB_ToolBar_Text)
   ToolBarStandardButton(0, #PB_ToolBarIcon_New,  0, "新建")
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open, 0, "打开")
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save, 0, "保存")
   ToolBarButtonText(#wtbScreen, 0, "新新新")
EndIf

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
; CursorPosition = 8
; EnableXP