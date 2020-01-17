;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_新增检测
;***********************************

Enumeration
   #winScreen
   #lstScreen
   #txtScreen
   #btnScreen
EndEnumeration

Procedure ListIcon_AddItem(GadgetID, ItemText$) 
   Protected LFI.LVFINDINFO 
   LFI\flags   = #LVFI_PARTIAL | #LVFI_STRING 
   LFI\psz     = @ItemText$
   If SendMessage_(GadgetID(GadgetID),#LVM_FINDITEM,-1,LFI) = -1 
      ProcedureReturn AddGadgetItem(GadgetID,-1,ItemText$) 
   Else 
      MessageRequester("提示","列表已经有该项内容,请不要重复添加!") 
   EndIf 
EndProcedure 


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 500, 300, "ListIconGadget_新增检测", WindowFlags)
ListIconGadget(#lstScreen,000,000,400, 300, "测试列", 245, #PB_ListIcon_FullRowSelect) 
StringGadget(#txtScreen, 410, 020, 080, 020, "测试内容5")
ButtonGadget(#btnScreen, 410, 050, 080, 030, "添加")
For k = 1 To 10
   AddGadgetItem(#lstScreen, -1, "测试内容"+Str(k))
Next 


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
         GadgetID  = EventGadget()
         If GadgetID = #btnScreen
            ItemText$ = GetGadgetText(#txtScreen)
            ListIcon_AddItem(#btnScreen, ItemText$) 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP
; EnableUnicode