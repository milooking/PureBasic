;***********************************
;迷路仟整理 2019.03.24
;ToolBar_下拉菜单功能1
;***********************************


Enumeration
   #winScreen
   #wtbScreen 
EndEnumeration

Global _hHookToolBar


Procedure Hook_ToolBar(hToolBar, uMsg, wParam, lParam)
   Select uMsg
      Case #WM_LBUTTONDOWN : Debug "#WM_LBUTTONDOWN"
      Case #WM_LBUTTONUP   : Debug "#WM_LBUTTONUP"
      Case #WM_MOUSEMOVE   : ;Debug "#WM_MOUSEMOVE"
   EndSelect
   If Result = #False
      Result = CallWindowProc_(_hHookToolBar, hToolBar, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure

UsePNGImageDecoder()
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ToolBar_下拉菜单功能1", WindowFlags)

hToolBar = CreateToolBar(#wtbScreen, hWindow)
If hToolBar
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

_hHookToolBar = SetWindowLongPtr_(hToolBar, #GWL_WNDPROC, @Hook_ToolBar())


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
; CursorPosition = 21
; FirstLine = 1
; Folding = -
; EnableXP