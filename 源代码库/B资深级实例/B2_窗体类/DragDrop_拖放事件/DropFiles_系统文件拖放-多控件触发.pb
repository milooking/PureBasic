;***********************************
;迷路仟整理 2019.03.22
;DropFiles_系统文件拖放-多控件触发
;***********************************

Enumeration
   #winScreen
   #txtScreen1
   #txtScreen2
   #txtScreen3
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

   GetCursorPos_(@Mouse.q)
   hGadget = WindowFromPoint_(Mouse)  
   Select hGadget
      Case GadgetID(#txtScreen1) : SetGadgetText(#txtScreen1, FileName$)
      Case GadgetID(#txtScreen2) : SetGadgetText(#txtScreen2, FileName$)
      Case GadgetID(#txtScreen3) : SetGadgetText(#txtScreen3, FileName$)
      Case WindowID(#winScreen)  : Debug FileName$
   EndSelect

   ProcedureReturn 
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget

hWindow = OpenWindow(#winScreen, 0, 0,400, 250, "DropFiles_系统文件拖放-多控件触发", WindowFlags)
StringGadget(#txtScreen1, 050,050,300,020, "")
StringGadget(#txtScreen2, 050,100,300,020, "")
StringGadget(#txtScreen3, 050,150,300,020, "")
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
; CursorPosition = 7
; Folding = -
; EnableXP