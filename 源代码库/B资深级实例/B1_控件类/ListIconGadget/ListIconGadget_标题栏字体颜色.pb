;***********************************
;迷路仟整理 2019.03.14
;ListIconGadget_标题栏字体颜色
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #fntScreen
EndEnumeration

Global _hGadgetHook

Procedure Gadget_Hook(hWindow, uMsg, wParam, lParam)
   Result = CallWindowProc_(_hGadgetHook, hWindow, uMsg, wParam, lParam)
   If uMsg = #WM_NOTIFY
      *NMHDR.NMHDR = lParam
      If *NMHDR\code = #NM_CUSTOMDRAW
         *NMCUSTOMDRAW.NMCUSTOMDRAW = lParam
         Select *NMCUSTOMDRAW\dwDrawStage
            Case #CDDS_PREPAINT
               Result = #CDRF_NOTIFYITEMDRAW
            Case #CDDS_ITEMPREPAINT
               If *NMCUSTOMDRAW\dwItemSpec = 1 ;第二列
                  SetTextColor_(*NMCUSTOMDRAW\hdc, #Blue)
               EndIf
         EndSelect
      EndIf
   EndIf

   ProcedureReturn Result
EndProcedure

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_标题栏字体颜色",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
   _hGadgetHook = SetWindowLongPtr_(hGadget, #GWL_WNDPROC,  @Gadget_Hook())
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = 0
; EnableXP
; EnableUnicode