;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_单元格事件
;***********************************
Enumeration
   #winScreen 
   #lstScreen
EndEnumeration

 
Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Select uMsg  
      Case #WM_NOTIFY 
         *pnmh.NMHDR = lParam 
         If *pnmh\hwndFrom = GadgetID(#lstScreen) 
            Select *pnmh\code 
               Case #LVN_COLUMNCLICK 
                  *pnmv.NMLISTVIEW = lParam
                  Column.l = *pnmv\iSubItem 
                  Debug "标题列: "+Str(Column) 
               Case #NM_CLICK
                  *lpnmitem.NMITEMACTIVATE = lParam  
                  Row.l = *lpnmitem\iItem  
                  Column.l = *lpnmitem\iSubItem  
                  
                  Rect.RECT  
                  Rect\top = Column  
                  Rect\left = #LVIR_BOUNDS  
                  SendMessage_(*pnmh\hwndFrom, #LVM_GETSUBITEMRECT, Row, Rect)  

                  Test$ = "内容列: " + "行: "+Str(Row)+" 列: "+Str(Column) 
                  Test$ + " X=" + Str(Rect\left) + " Y=" + Str(Rect\top)
                  Debug Test$
            EndSelect  
         EndIf  
   EndSelect  
   
   ProcedureReturn Result  
EndProcedure  
 

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_单元格事件",WindowFlags) 
   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
   SetWindowCallback(@Window_Callback()) 
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; FirstLine = 27
; Folding = -
; EnableXP
; Executable = 自修改程序.exe