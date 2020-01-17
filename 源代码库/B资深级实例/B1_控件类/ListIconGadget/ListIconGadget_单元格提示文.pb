;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_单元格提示文
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration


Global _hToolTip, _ToolInfo.TOOLINFO
      
Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Static item, subitem, olditem, oldsubitem ,Run
   Select uMsg
      Case #WM_NOTIFY
         *nmhdr.NMHDR = lParam
         If *nmhdr\hwndFrom = GadgetID(#lstScreen)
            *nmlv.NM_LISTVIEW = lParam
            If *nmlv\hdr\code = #LVN_HOTTRACK           
               item = *nmlv\iitem             
               subitem = *nmlv\isubitem
               If (item <> olditem  Or subitem <> oldsubitem Or Run = 0) And item >= 0
                  Run = 1
                  _ToolInfo\cbSize   = SizeOf(_ToolInfo)
                  _ToolInfo\uFlags   = #TTF_IDISHWND | #TTF_SUBCLASS
                  _ToolInfo\uId      = *nmhdr\hwndFrom
                  SendMessage_(_hToolTip, #TTM_DELTOOL, 0, _ToolInfo)
                  Text$ = "提示文: 行 "+Str(item) + " 列 " +Str(subitem)
                  _ToolInfo\lpszText = @Text$
                  SendMessage_(_hToolTip, #TTM_ADDTOOL, 0, _ToolInfo)              
                  olditem    = item
                  oldsubitem = subitem
               EndIf                   
            EndIf
         EndIf     
   EndSelect  
   ProcedureReturn Result  
EndProcedure  

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_单元格提示文",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect|#PB_ListIcon_GridLines) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)

   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
   
   GadgetToolTip(#lstScreen, "") ;这个必须的,否则FindWindow()不到
   _hToolTip = FindWindow_(@"tooltips_class32", 0)
   SendMessage_(_hToolTip, #TTM_SETDELAYTIME, #TTDT_AUTOMATIC,200)      
   SendMessage_(_hToolTip, #TTM_SETDELAYTIME, #TTDT_INITIAL,10)
   SetWindowCallback(@Window_Callback())  
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; Folding = 0
; EnableXP
; EnableUnicode