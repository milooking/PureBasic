;***********************************
;迷路仟整理 2017.06.09
;ListIconGadget_XP分类风格
;***********************************

#winScreen = 0
#lstScreen = 0
 
Procedure ListIcon_AddGroup(GadgetID.l, text.s, groupid.l) 
   lvg.LVGROUP\cbSize = SizeOf(LVGROUP) 
   lvg\mask   = #LVGF_HEADER | #LVGF_GROUPID | #LVGF_ALIGN | #LVGF_STATE 
   lvg\iGroupId = groupid 
   lvg\cchHeader = 7
   lvg\state  = #LVGS_COLLAPSIBLE
   lvg\uAlign = #LVGA_HEADER_LEFT 
   
   lvg\pszHeader = @text
   SendMessage_ (GadgetID(GadgetID), #LVM_INSERTGROUP, -1, @lvg) 
   ProcedureReturn groupid
EndProcedure 
 
Procedure ListIcon_EnableGroupView(GadgetID.l, state.l) 
   SendMessage_ (GadgetID(GadgetID), #LVM_ENABLEGROUPVIEW, state, 0) 
EndProcedure 
 
Procedure ListIcon_AddItem(GadgetID.l, text.s, groupid.l) 
   itm.LVITEM\mask = #LVIF_TEXT | #LVIF_GROUPID 
   itm\pszText  = @text 
   itm\iGroupId = groupid 
   SendMessage_ (GadgetID(GadgetID), #LVM_INSERTITEM, 0, @itm) 
EndProcedure 
 
 
 
If OpenWindow(#winScreen, 0, 0, 300, 400, "ListIconGadget-XP分类风格", #PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_ScreenCentered) 
   hWindow = ListIconGadget(#lstScreen, 5, 5, 290, 390, "XP分类风格", 200, #PB_ListIcon_CheckBoxes) 
   
   ListIcon_EnableGroupView(#lstScreen, 1) 
   For g=1 To 5 
      ListIcon_AddGroup(#lstScreen, "分组 "+Str(g), g) 
      For i=1 To 5 
         ListIcon_AddItem(#lstScreen, "分组"+Str(g) + "-子项"+Str((g-1)*5+i), g) 
      Next 
   Next 

   Repeat 
      Select WaitWindowEvent() 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_SizeWindow 
            ResizeGadget(#lstScreen, 5, 5, WindowWidth(#winScreen)-10, WindowHeight(#winScreen)-10) 
      EndSelect 
   Until IsExitWindow = #True
EndIf 
End 
 
 


















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP
; EnableUnicode