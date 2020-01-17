;***********************************
;迷路仟整理 2019.01.18
;列表框浏览器隐藏标题栏
;***********************************

Enumeration
   #WinScreen
   #flvScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "列表框浏览器隐藏标题栏", WindowFlags)

hGadget = ExplorerListGadget(#flvScreen, 10, 10, 380, 230, "*.*", #PB_Explorer_MultiSelect)
hHeader = SendMessage_(hGadget, #LVM_GETHEADER, 0, 0)  
Style   = GetWindowLong_(hHeader, #GWL_STYLE)
SetWindowLong_(hHeader, #GWL_STYLE, Style | #HDS_HIDDEN)  


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
; CursorPosition = 1
; Folding = -
; EnableXP