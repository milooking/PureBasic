;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_固定列宽
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration

Global _hHookGadget

Procedure Header_CallBack(hGadget,uMsg,wParam,lParam)  
   Select uMsg  
      Case #WM_NOTIFY  
         *hdr.NMHDR = lParam  
         If *hdr\code= #HDN_BEGINTRACKW 
            Result = #True  
         EndIf   
      Default  
         Result = CallWindowProc_(_hHookGadget,hGadget,uMsg,wParam,lParam)  
   EndSelect  
   ProcedureReturn Result  
EndProcedure   


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_固定列宽",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_CheckBoxes) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
  _hHookGadget = SetWindowLong_(hGadget, #GWL_WNDPROC, @Header_CallBack())  
  
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; FirstLine = 19
; Folding = -
; EnableXP
; EnableUnicode