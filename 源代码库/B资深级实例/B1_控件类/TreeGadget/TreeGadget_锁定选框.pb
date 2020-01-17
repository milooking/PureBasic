;***********************************
;迷路仟整理 2019.03.14
;TreeGadget_锁定选框
;***********************************

Enumeration
   #WinScreen
   #tvwScreen
   #btnProtect
EndEnumeration

#LVIS_UNCHECKED = $1000
#LVIS_CHECKED   = $2000

Procedure ListIconGadget_CallBack(hWindow, uMsg, wParam, lParam)
   Result = #PB_ProcessPureBasicEvents
   Select uMsg
      Case #WM_NOTIFY
         If GetGadgetState(#btnProtect)
            *nmt.NMTREEVIEW = lParam
             tvhti.TV_HITTESTINFO
            If *nmt\hdr\hwndFrom = GadgetID(#tvwScreen)
               If *nmt\hdr\code = #NM_CLICK 
                  GetCursorPos_(@tvhti\pt)
                  ScreenToClient_(*nmt\hdr\hwndFrom, @tvhti\pt)
                  If SendMessage_(*nmt\hdr\hwndFrom, #TVM_HITTEST, 0, @tvhti)
                     If tvhti\hItem
                        If tvhti\flags = #TVHT_ONITEMSTATEICON
                           Result = #True
                        EndIf
                     EndIf
                  EndIf
               ElseIf *nmt\hdr\code = -24
                  Result = #True
               EndIf
            EndIf
         EndIf
   EndSelect
   ProcedureReturn Result
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "TreeGadget_锁定选框", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = TreeGadget(#tvwScreen, 010, 010, 380, 200, #PB_Tree_CheckBoxes) 
ButtonGadget(#btnProtect, 150, 220, 100, 030, "锁定选框", #PB_Button_Toggle)

For i=0 To 99
  AddGadgetItem(#tvwScreen, -1, "节点内容 " + Str(i), 0, Random(2))
Next

SetWindowCallback(@ListIconGadget_CallBack())   

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; FirstLine = 4
; Folding = -
; EnableXP