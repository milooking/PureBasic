;***********************************
;迷路仟整理 2019.01.17
;编辑框控件
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "编辑框控件", WindowFlags)

EditorGadget(#rtxScreen, 005, 005, 390, 120)
SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")
For k = 0 To 5
   AddGadgetItem(#rtxScreen, -1, "添加行文本 - "+Str(k))
Next
AddGadgetItem(#rtxScreen, 0, "首行插入文本<<<<<<<<<<<<<< ")
SetGadgetColor(#rtxScreen, #PB_Gadget_FrontColor, $0000FF)
SetGadgetColor(#rtxScreen, #PB_Gadget_BackColor,  $CFFFFF)

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
; CursorPosition = 16
; Folding = -
; EnableXP