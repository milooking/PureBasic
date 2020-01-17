;***********************************
;迷路仟整理 2019.01.15
;按键控件和样式
;***********************************

Enumeration
   #WinScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
   #btnScreen5
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 200, "按键控件和样式", WindowFlags)

ButtonGadget(#btnScreen1, 010, 010, 200, 35, "标准按键")
ButtonGadget(#btnScreen2, 010, 050, 200, 35, "左对齐", #PB_Button_Left)
ButtonGadget(#btnScreen3, 010, 090, 200, 35, "右对齐", #PB_Button_Right)
ButtonGadget(#btnScreen4, 220, 010, 200, 75, "多行显示"+#LF$+"文本内容", #PB_Button_MultiLine)
ButtonGadget(#btnScreen5, 220, 090, 200, 35, "开关功能", #PB_Button_Toggle)
    
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
; CursorPosition = 13
; FirstLine = 4
; Folding = -
; EnableXP