;***********************************
;迷路仟整理 2019.01.17
;编辑框响应事件
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "编辑框响应事件", WindowFlags)

EditorGadget(#rtxScreen, 005, 005, 390, 120)
SetGadgetText(#rtxScreen, "编辑框响应事件:")
For k = 0 To 5
   AddGadgetItem(#rtxScreen, -1, "添加行文本 - "+Str(k))
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #rtxScreen
            Select EventType()
               Case #PB_EventType_Change     : Debug "#PB_EventType_Change"
               Case #PB_EventType_Focus      : Debug "#PB_EventType_Focus"
               Case #PB_EventType_LostFocus  : Debug "#PB_EventType_LostFocus"
            EndSelect
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP