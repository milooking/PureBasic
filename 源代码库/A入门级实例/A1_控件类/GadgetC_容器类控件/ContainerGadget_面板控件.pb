;***********************************
;迷路仟整理 2019.01.17
;面板控件
;***********************************

Enumeration
   #WinScreen
   #frmScreen
   #btnScreen
   #txtScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "面板控件", WindowFlags)

ContainerGadget(#frmScreen, 010, 010, 300, 100, #PB_Container_Raised)
   StringGadget(#txtScreen, 010, 015, 080, 024, "")
   ButtonGadget(#btnScreen, 100, 015, 080, 024, "按键")
CloseGadgetList()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug EventGadget()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; Folding = -
; EnableXP