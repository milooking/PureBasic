;***********************************
;迷路仟整理 2019.01.15
;工具栏提示文
;***********************************

#winScreen = 0
#wtbScreen = 0
#btnScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "工具栏提示文", WindowFlags)

If CreateToolBar(#wtbScreen, hWindow)
   ToolBarStandardButton(0, #PB_ToolBarIcon_New)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save)
   ToolBarToolTip(#wtbScreen, 0, "新.新..新建..建..文件")
   ToolBarToolTip(#wtbScreen, 1, "打.打..打开.开..开文件")
   ToolBarToolTip(#wtbScreen, 2, "保保..保..存.存.存...文件")
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
; CursorPosition = 9
; EnableXP