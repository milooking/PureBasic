;***********************************
;迷路仟整理 2019.01.17
;DragFiles_拖放文件
;***********************************

Enumeration
   #WinScreen
   #flvSource
   #lvwTarget
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 400, "DragFiles_拖放文件", WindowFlags)
ExplorerListGadget(#flvSource, 010, 010, 380, 230, GetHomeDirectory(), #PB_Explorer_MultiSelect)
ListViewGadget    (#lvwTarget, 010, 250, 380, 140)
EnableGadgetDrop  (#lvwTarget, #PB_Drop_Files, #PB_Drag_Copy)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #flvSource And EventType() = #PB_EventType_DragStart
            FileNames$ = ""       
            For i = 0 To CountGadgetItems(#flvSource)-1
               If GetGadgetItemState(#flvSource, i) & #PB_Explorer_Selected
                  FileNames$ + GetGadgetText(#flvSource) + GetGadgetItemText(#flvSource, i) + #LF$
               EndIf
            Next      
            DragFiles(FileNames$)
         EndIf 
      Case #PB_Event_GadgetDrop
        If EventGadget() = #lvwTarget
            Files$ = EventDropFiles()
            Count  = CountString(Files$, #LF$) + 1
            For i = 1 To Count
               AddGadgetItem(#lvwTarget, -1, StringField(Files$, i, #LF$))
            Next
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; Folding = -
; EnableXP