;***********************************
;迷路仟整理 2019.03.14
;TreeGadget_节点编辑,不支持中文编辑,按回车有效
;***********************************

Enumeration
   #WinScreen
   #tvwScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "TreeGadget_节点编辑", WindowFlags)

GadgetFlags = #PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_GridLines
hGadget = TreeGadget(#tvwScreen, 010, 010, 380, 240) 

For a = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "节点 "+Str(a), 0, 0)
   AddGadgetItem(#tvwScreen, -1, "子项 1", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子项 4", 0, 1)
Next
GadgetStyle = GetWindowLongPtr_(hGadget,#GWL_STYLE)
SetWindowLongPtr_(hGadget, #GWL_STYLE,  GadgetStyle| #TVS_EDITLABELS)
 
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #WM_KEYDOWN
         Debug Hex(EventlParam())
            If EditFlag = #True And EventwParam() = #CR

                SetGadgetItemText(#tvwScreen, EditItem, EditText$)
                EditFlag = #False
            EndIf   
      Case #WM_CHAR
         If EditFlag  = #True
            hEditor = SendMessage_(hGadget, #TVM_GETEDITCONTROL, 0, 0)
            If EventwParam() >= 32
                EditText$ = EditText$+ Chr(EventwParam())
            EndIf
         EndIf
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #tvwScreen
               If EventType() = #PB_EventType_LeftDoubleClick
                  EditItem = GetGadgetState(#tvwScreen)
                  EditFlag  = #True
                  EditText$ = #Null$
                  SendMessage_(hGadget,#TVM_EDITLABEL,0, GadgetItemID(#tvwScreen, EditItem))
               EndIf 
          EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP