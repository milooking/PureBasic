;***********************************
;迷路仟整理 2019.01.17
;限制字符长度
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "限制字符长度", WindowFlags)

hGadget = EditorGadget (#rtxScreen, 005, 005, 390, 200)

SetGadgetText(#rtxScreen, "只能写入十个字符")
SendMessage_(hGadget, #EM_LIMITTEXT, 10, 0)
  
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
; CursorPosition = 19
; Folding = -
; EnableXP