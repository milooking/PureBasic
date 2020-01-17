;***********************************
;迷路仟整理 2019.03.15
;FileIcon_获取文件类型图标
;***********************************

Enumeration
   #winScreen
   #picScreen
EndEnumeration


;-
Procedure GetFileIcon(FileName$)
   SHGetFileInfo_(FileName$, 0, @FileInfo.SHFILEINFO, SizeOf(SHFILEINFO), $20|#SHGFI_ICON|#SHGFI_LARGEICON)
   ProcedureReturn FileInfo\hIcon
EndProcedure


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "FileIcon_获取文件ICO", WindowFlags)

hIcon = GetFileIcon(".\FileIcon_获取文件类型图标.pb")
ImageGadget(#picScreen, 180, 100, 32, 32, hIcon)

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
; CursorPosition = 24
; Folding = -
; EnableXP
; EnableOnError