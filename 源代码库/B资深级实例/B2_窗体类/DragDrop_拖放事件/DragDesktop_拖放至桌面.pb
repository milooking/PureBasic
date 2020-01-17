;***********************************
;迷路仟整理 2016.03.14
;DragDesktop_拖放至桌面,可以从窗体中件拖放文件到桌面或任意文件夹窗体中
;***********************************

Enumeration
   #winScreen 
   #lstScreen
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "DragDesktop_拖放至桌面", WindowFlags)
hGadget1 = ListIconGadget(#lstScreen,010,010,380, 230, "文件名", 245, #PB_ListIcon_MultiSelect|#PB_ListIcon_FullRowSelect) 

For k = 1 To 10
   AddGadgetItem(#lstScreen, -1, "测试内容"+Str(k)+".txt")
Next 
EnableGadgetDrop(#lstScreen, #PB_Drop_Files, #PB_Drag_Move)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      ;拖放源事件
      Case #PB_Event_Gadget
         If EventType() = #PB_EventType_DragStart
            Select EventGadget()
               Case #lstScreen
                  State = GetGadgetState(#lstScreen)
                  FileName$ = GetCurrentDirectory()+GetGadgetItemText(#lstScreen, State)
                  CreateFile(0, FileName$)
                  CloseFile(0)
                  DragFiles(FileName$)  ;加上这一句,拖至窗体外才有光标特效
                  Debug FileName$
            EndSelect
         EndIf 
      Case #PB_Event_GadgetDrop
      Case #PB_Event_DeactivateWindow
          DeleteFile(FileName$)
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 41
; FirstLine = 14
; Folding = -
; EnableXP
; EnableUnicode