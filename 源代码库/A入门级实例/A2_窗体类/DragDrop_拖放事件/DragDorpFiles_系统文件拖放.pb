;***********************************
;迷路仟整理 2019.03.14
;DragDorpFiles_系统文件拖放
;***********************************

Enumeration
   #winScreen
   #imgScreen
EndEnumeration

Procedure GetDragDorpFiles()
   File$ = EventDropFiles()
   Count = CountString(File$, #LF$)
   For i = 0 To Count
      Debug StringField(File$, i+1, #LF$)
   Next
EndProcedure



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "系统文件拖放", WindowFlags)

EnableWindowDrop(0, #PB_Drop_Files, #PB_Drag_Copy)
BindEvent(#PB_Event_WindowDrop, @GetDragDorpFiles(), 0)
      
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; Folding = -
; EnableXP