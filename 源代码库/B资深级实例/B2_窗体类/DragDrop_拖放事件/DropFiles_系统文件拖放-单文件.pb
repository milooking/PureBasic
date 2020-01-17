;***********************************
;迷路仟整理 2019.02.02
;DropFiles_系统文件拖放-单文件
;***********************************

Enumeration
   #winScreen
   #lvwScreen
EndEnumeration

;获取系统拖放文件(单文件)
Procedure Screen_DragDorpFile() 
   DroppedID = EventwParam()  
   CountFiles = DragQueryFile_(DroppedID, $FFFFFFFF, "", 0) 
   If CountFiles
      LenFileName  = DragQueryFile_(DroppedID, 0, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, 0, FileName$, LenFileName+1) 
   EndIf 
   DragFinish_(DroppedID) 
   If FileSize(FileName$) > 0 
      AddGadgetItem(#lvwScreen, -1, FileName$)
   EndIf 
   ProcedureReturn 
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget

hWindow = OpenWindow(#winScreen, 0, 0,600, 350, "系统文件拖放-单文件", WindowFlags)
ListViewGadget(#lvwScreen, 000,000,600,350)
DragAcceptFiles_(hWindow, #True) ;设置窗体界面是否支持系统拖放.

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_DROPFILES         : Screen_DragDorpFile()
   EndSelect      
   Delay(1)
Until IsExitWindow = #True
DragFinish_(hWindow) 
End



















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 44
; FirstLine = 18
; Folding = -
; EnableXP