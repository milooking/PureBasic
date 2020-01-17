;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_选项框事件
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration

Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Select uMsg  
      Case #WM_NOTIFY  
         *pnmhdr.NMHDR = lParam  
         Select *pnmhdr\code  
            Case #LVN_ITEMCHANGED  
               *lvChange.NMLISTVIEW = lParam  
               Select *lvChange\uNewState >>12 &$FFFF  
                  Case 1  : Debug "Item" + Str(*lvChange\iItem) + ": 取消打勾"
                  Case 2  : Debug "Item" + Str(*lvChange\iItem) + ": 打勾" 
               EndSelect  
         EndSelect  
   EndSelect  
   ProcedureReturn Result  
EndProcedure  


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_选项框事件",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_CheckBoxes) 
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
; CursorPosition = 33
; FirstLine = 12
; Folding = -
; EnableXP
; EnableUnicode