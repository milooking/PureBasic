;***********************************
;迷路仟整理 2019.03.24
;ToolBar_下拉菜单功能2
;***********************************


Enumeration
   #winScreen
   #wtbScreen 
EndEnumeration

Global _hHookWindow

Procedure Hook_Window(hWindow, uMsg, wParam, lParam)
   Select uMsg
      Case #WM_NOTIFY 
         *nmt.NMTOOLBAR = lParam
         If *nmt\hdr\code = #TBN_DROPDOWN
             MapWindowPoints_(hWindow, 0, *nmt\rcButton, 2)
             Debug "xxxxx"
         EndIf 
   EndSelect
   If Result = #False
      Result = CallWindowProc_(_hHookWindow, hWindow, uMsg, wParam, lParam)
   EndIf 
   ProcedureReturn Result
EndProcedure

UsePNGImageDecoder()
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ToolBar_下拉菜单功能2", WindowFlags)

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

   ;设置下菜风格
   SendMessage_(hToolBar, #TB_SETEXTENDEDSTYLE, 0, #TBSTYLE_EX_DRAWDDARROWS)
   tbbi.TBBUTTONINFO
   tbbi\dwMask = #TBIF_BYINDEX|#TBIF_STYLE
   tbbi\cbSize = SizeOf(TBBUTTONINFO)
   SendMessage_(hToolBar, #TB_GETBUTTONINFO, 8, @tbbi)
   tbbi\fsStyle|#BTNS_DROPDOWN
   SendMessage_(hToolBar, #TB_SETBUTTONINFO, 8, @tbbi)
EndIf
_hHookWindow = SetWindowLongPtr_(hWindow, #GWL_WNDPROC, @Hook_Window())

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
; CursorPosition = 27
; FirstLine = 3
; Folding = -
; EnableXP