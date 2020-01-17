;***********************************
;迷路仟整理 2019.01.18
;框架控件
;***********************************

Enumeration
   #WinScreen
   #lfmScreen1
   #lfmScreen2
   #lfmScreen3
   #lfmScreen4
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "框架控件", WindowFlags)

FrameGadget(#lfmScreen1, 10,  10, 300, 50, "标准样式")
FrameGadget(#lfmScreen2, 10,  70, 300, 50, "", #PB_Frame_Single)
FrameGadget(#lfmScreen3, 10, 130, 300, 50, "", #PB_Frame_Double)
FrameGadget(#lfmScreen4, 10, 190, 300, 50, "", #PB_Frame_Flat)


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
; CursorPosition = 2
; Folding = -
; EnableXP