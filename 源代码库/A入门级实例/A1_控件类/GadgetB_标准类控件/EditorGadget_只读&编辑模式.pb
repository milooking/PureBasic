;***********************************
;迷路仟整理 2019.01.17
;只读/编辑模式
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "只读/编辑模式", WindowFlags)

ButtonGadget(#btnScreen, 150, 180, 100, 030, "编辑模式", #PB_Button_Toggle)
EditorGadget(#rtxScreen, 005, 005, 390, 120)

SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")
For k = 0 To 5
   AddGadgetItem(#rtxScreen, -1, "添加行文本 - "+Str(k))
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            If GetGadgetState(#btnScreen)
               SetGadgetText(#btnScreen, "只读模式")
               SetGadgetAttribute(#rtxScreen, #PB_Editor_ReadOnly, #True)
            Else 
               SetGadgetText(#btnScreen, "编辑模式")
               SetGadgetAttribute(#rtxScreen, #PB_Editor_ReadOnly, #False)
            EndIf 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP