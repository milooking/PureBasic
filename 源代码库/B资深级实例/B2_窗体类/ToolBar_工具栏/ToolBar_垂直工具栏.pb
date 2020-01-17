;***********************************
;迷路仟整理 2019.01.15
;垂直工具栏
;***********************************


Enumeration
   #winScreen
   #wtbScreen 
   #frmScreen 
EndEnumeration


UsePNGImageDecoder()
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 300, "垂直工具栏", WindowFlags)

hGadget = ContainerGadget(#frmScreen, 5, 5, 25, 290)
   hToolBar = CreateToolBar(#wtbScreen, hGadget)
   If hToolBar
      TBSTYLE = GetWindowLong_(hToolBar, #GWL_STYLE)
      SetWindowLong_(hToolBar, #GWL_STYLE,TBSTYLE|#TBSTYLE_WRAPABLE) 
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
CloseGadgetList()

; ;大图标模式
; hGadget = ContainerGadget(#frmScreen, 5, 5, 40, 290)
;    hToolBar = CreateToolBar(#wtbScreen, hGadget)
;    If hToolBar
;       TBSTYLE = GetWindowLong_(hToolBar, #GWL_STYLE)
;       SetWindowLong_(hToolBar, #GWL_STYLE,TBSTYLE|#TBSTYLE_WRAPABLE) 
;       ImageList = SendMessage_(hToolBar, #TB_GETIMAGELIST, 0, 0)
;       ImageList_SetIconSize_(ImageList, 32, 32)
;       ToolBarImageButton(0, LoadImage(0, #PB_Compiler_Home + "examples/sources/Data/ToolBar/New.png"))
;       ToolBarImageButton(1, LoadImage(1, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Open.png"))
;       ToolBarImageButton(2, LoadImage(2, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Save.png"))
;       ToolBarSeparator()
;       ToolBarImageButton(3, LoadImage(3, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Cut.png"))
;       ToolBarToolTip(#wtbScreen, 3, "剪切")
;       ToolBarImageButton(4, LoadImage(4, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Copy.png"))
;       ToolBarToolTip(#wtbScreen, 4, "复制")
;       ToolBarImageButton(5, LoadImage(5, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Paste.png"))
;       ToolBarToolTip(#wtbScreen, 5, "粘贴")
;       ToolBarSeparator()
;       ToolBarImageButton(6, LoadImage(6, #PB_Compiler_Home + "examples/sources/Data/ToolBar/Find.png"))
;       ToolBarToolTip(#wtbScreen, 6, "查找")
;    EndIf
; CloseGadgetList()

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
; CursorPosition = 42
; FirstLine = 36
; Folding = -
; EnableXP