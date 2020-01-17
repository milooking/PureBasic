;***********************************
;迷路仟整理 2019.03.14
;ListIconGadget_锁定选框
;***********************************

Enumeration
   #WinScreen
   #lstScreen
   #btnProtect
EndEnumeration

#LVIS_UNCHECKED = $1000
#LVIS_CHECKED   = $2000

Procedure ListIconGadget_CallBack(hWindow, uMsg, wParam, lParam)
   Result = #PB_ProcessPureBasicEvents 
   Select uMsg   
      Case #WM_NOTIFY     
         *nmhdr.NMHDR = lParam     
         If *nmhdr\hwndFrom = GadgetID(#lstScreen)
            If *nmhdr\code = #LVN_ITEMCHANGING
               *nmlv.NM_LISTVIEW = lParam           
               If *nmlv\uChanged=#LVIF_STATE
                  Select *nmlv\uNewState
                     Case #LVIS_UNCHECKED, #LVIS_CHECKED
                        If GetGadgetState(#btnProtect)
                           Result = #True
                        EndIf
                  EndSelect
               EndIf
            EndIf
         EndIf 
   EndSelect
   ProcedureReturn Result
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "ListIconGadget_锁定选框", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = ListIconGadget(#lstScreen, 010, 010, 380, 200,"内容",310, GadgetFlags) 
ButtonGadget(#btnProtect, 150, 220, 100, 030, "锁定选框", #PB_Button_Toggle)
For Row = 1 To 50
  AddGadgetItem(#lstScreen, -1, "内容行 "+RSet(Str(Row),2,"0"))   
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
; CursorPosition = 4
; Folding = -
; EnableXP