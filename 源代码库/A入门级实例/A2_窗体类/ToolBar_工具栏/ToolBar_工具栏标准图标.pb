;***********************************
;迷路仟整理 2019.01.15
;工具栏_标准图标
;***********************************

#winScreen = 0
#wtbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "工具栏_标准图标", WindowFlags)

If CreateToolBar(#wtbScreen, hWindow)
   ToolBarStandardButton(0, #PB_ToolBarIcon_New)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save)
EndIf

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu  : Debug "ToolBar ID: "+Str(EventMenu())
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP