;***********************************
;迷路仟整理 2019.02.02
;DropFiles_系统文件拖放-多文件
;***********************************

Enumeration
   #winScreen
   #lvwScreen
EndEnumeration

;获取系统拖放文件(多文件)
Procedure Screen_DragDorpFiles() 
   DroppedID = EventwParam()  
   GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
   For k = 0 To GetCount - 1  
      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
      FileSize = FileSize(FileName$)
      If FileSize > 0   
         CountFiles + 1
         AddGadgetItem(#lvwScreen, -1, FileName$)
      ElseIf FileSize = -2
         CountFiles + 1
         If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
         AddGadgetItem(#lvwScreen, -1, "文件夹: " + FileName$)
      EndIf 
   Next  
   DragFinish_(DroppedID) 
   If CountFiles
      AddGadgetItem(#lvwScreen, -1, "----------- 华丽的分隔线 -----------")
   EndIf 
   ProcedureReturn 
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget

hWindow = OpenWindow(#winScreen, 0, 0,600, 350, "系统文件拖放-多文件", WindowFlags)
ListViewGadget(#lvwScreen, 000,000,600,350)
DragAcceptFiles_(hWindow, #True) ;设置窗体界面是否支持系统拖放.

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_DROPFILES         : Screen_DragDorpFiles()
   EndSelect      
   Delay(1)
Until IsExitWindow = #True
DragFinish_(hWindow) 
End



















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 53
; FirstLine = 4
; Folding = 0
; EnableXP