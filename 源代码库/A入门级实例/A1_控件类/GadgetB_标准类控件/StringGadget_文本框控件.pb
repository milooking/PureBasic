;***********************************
;迷路仟整理 2019.01.20
;文本框控件
;***********************************

Enumeration
   #winScreen
   #txtScreen1
   #txtScreen2
   #txtScreen3
   #txtScreen4
   #txtScreen5
   #txtScreen6
   #txtScreen7
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "文本框控件", WindowFlags)

StringGadget(#txtScreen1, 010, 010, 380, 20, "标准文本框")
StringGadget(#txtScreen2, 010, 035, 380, 20, "1234567", #PB_String_Numeric)
StringGadget(#txtScreen3, 010, 060, 380, 20, "只读模式", #PB_String_ReadOnly)
StringGadget(#txtScreen4, 010, 085, 380, 20, "小写模式 ABCefg", #PB_String_LowerCase)
StringGadget(#txtScreen5, 010, 110, 380, 20, "大写模式 ABCefg", #PB_String_UpperCase)
StringGadget(#txtScreen6, 010, 140, 380, 20, "无边框模式", #PB_String_BorderLess)
StringGadget(#txtScreen7, 010, 170, 380, 20, "密码模式", #PB_String_Password)

SetGadgetColor(#txtScreen2, #PB_Gadget_BackColor, RGB(255,255,225))
SetGadgetColor(#txtScreen6, #PB_Gadget_FrontColor, RGB(255,0,0))

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
; CursorPosition = 29
; Folding = -
; EnableXP