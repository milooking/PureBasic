;***********************************
;迷路仟整理 2019.01.15
;工具栏_自定义图标
;***********************************

#winScreen = 0
#wtbScreen = 0
UsePNGImageDecoder()

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "工具栏_自定义图标", WindowFlags)

If CreateToolBar(#wtbScreen, hWindow)
    ToolBarImageButton(0, LoadImage(0, #PB_Compiler_Home + "examples/sources/Data/ToolBar/New.png"))
    ToolBarImageButton(1, LoadImage(1, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Open.png"))
    ToolBarImageButton(2, LoadImage(2, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Save.png"))
    ToolBarSeparator()
    ToolBarImageButton(3, LoadImage(3, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Cut.png"))
    ToolBarToolTip(#wtbScreen, 3, "剪切")
    ToolBarImageButton(4, LoadImage(4, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Copy.png"))
    ToolBarToolTip(#wtbScreen, 4, "复制")
    ToolBarImageButton(5, LoadImage(5, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Paste.png"))
    ToolBarToolTip(#wtbScreen, 5, "粘贴")
    ToolBarSeparator()
    ToolBarImageButton(6, LoadImage(6, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Find.png"))
    ToolBarToolTip(#wtbScreen, 6, "查找")
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
; CursorPosition = 2
; EnableXP