;***********************************
;迷路仟整理 2019.01.18
;IP地址控件
;***********************************

Enumeration
   #WinScreen
   #ipdScreen
   #fntScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "IP地址控件", WindowFlags)
IPAddress = MakeIPAddress(127, 0, 0, 1)
IPAddressGadget(#ipdScreen, 10, 15, 160, 20)
SetGadgetState(#ipdScreen, IPAddress)

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
; CursorPosition = 17
; Folding = -
; EnableXP