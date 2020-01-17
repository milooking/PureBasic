;***********************************
;迷路仟整理 2019.01.20
;禁止刷新控件
;***********************************

Enumeration
   #WinScreen
   #lstScreen
   #prbScreen
EndEnumeration

Procedure Thread_ShowListIcon(hGadget)
   SetActiveGadget(#lstScreen)
;    SendMessage_(hGadget,#WM_SETREDRAW, #False, 0)
   For k = 1 To 9999
      AddGadgetItem (#lstScreen, 0, RSet(Str(k), 4, "0"))
      If k % 100 = 1 
         SendMessage_(hGadget,#WM_SETREDRAW, #True, 0)
         SendMessage_(hGadget,#WM_SETREDRAW, #False, 0)
      EndIf 
   Next
   SendMessage_(hGadget,#WM_SETREDRAW, #True, 0)
   Debug "加载完毕!"
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "ListIconGadget_禁止刷新控件", WindowFlags)


hGadget = ListIconGadget(#lstScreen, 010, 010, 380, 240,"内容",110, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection) 

CreateThread(@Thread_ShowListIcon(), hGadget)


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
; CursorPosition = 5
; Folding = -
; EnableXP