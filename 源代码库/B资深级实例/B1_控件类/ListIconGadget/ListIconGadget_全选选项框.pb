;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_全选选项框
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration

#HDS_CHECKBOXES    = $0400
#HDF_CHECKBOX      = $00000040
#HDF_CHECKED       = $00000080
#HDF_FIXEDWIDTH    = $00000100
#HDN_ITEMSTATEICONCLICK = #HDN_FIRST - 16
#LVIS_CHECKED = $2000
#LVIS_UNCHECKED = $1000

Global _hHeader

Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Select uMsg  
      Case #WM_NOTIFY 
         *pNMH.NMHEADER = lParam
         If *pNMH\hdr\hwndFrom = _hHeader
            Select *pNMH\hdr\code        
               Case #HDN_ITEMSTATEICONCLICK 
                  LVItem.LV_ITEM
                  Mask.HDITEM
                  Mask\mask = #HDI_FORMAT
                  SendMessage_(_hHeader, #HDM_GETITEM, 0, Mask)
                  If Mask\fmt & #HDF_CHECKED
                     LVItem\mask       =#LVIF_STATE
                     LVItem\stateMask  =#LVIS_STATEIMAGEMASK
                     LVItem\state      =#LVIS_UNCHECKED
                     SendMessage_(GadgetID(#lstScreen),#LVM_SETITEMSTATE,-1,LVItem)
                     Debug "取消"
                  Else
                     LVItem\mask       =#LVIF_STATE
                     LVItem\stateMask  =#LVIS_STATEIMAGEMASK
                     LVItem\state      =#LVIS_CHECKED
                     SendMessage_(GadgetID(#lstScreen),#LVM_SETITEMSTATE,-1,LVItem)
                     Debug "全选"
                  EndIf
            EndSelect      
         EndIf  
   EndSelect  
   ProcedureReturn Result  
EndProcedure  


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_全选选项框",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",25, #PB_ListIcon_CheckBoxes) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   AddGadgetColumn(#lstScreen, 3, "列-4",110)
   
   _hHeader = SendMessage_(hGadget, #LVM_GETHEADER, 0, 0)
   Style   =  GetWindowLongPtr_(_hHeader, #GWL_STYLE)
   SetWindowLongPtr_(_hHeader, #GWL_STYLE, Style|#HDS_CHECKBOXES)   

   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, #LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next

   SetWindowCallback(@Window_Callback())  
   Mask.HDITEM
   Mask\mask = #HDI_FORMAT
   Mask\fmt = #HDF_CHECKBOX|#HDF_FIXEDWIDTH;|#HDF_CHECKED
   SendMessage_(_hHeader, #HDM_SETITEM, 0, Mask)  
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP
; EnableUnicode