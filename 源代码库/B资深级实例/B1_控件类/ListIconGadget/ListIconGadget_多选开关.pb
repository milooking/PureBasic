;***********************************
;迷路仟整理 2015.07.06
;多选开关,多选状态时,按Ctrl+鼠标左键,可以进行多选
;***********************************

#winScreen = 0
#lstScreen = 1
#btnScreen = 2


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 500, 300, "ListIconGadget_多选开关", WindowFlags)


ListIconGadget(#lstScreen,000,000,400, 300, "文件名", 245, #PB_ListIcon_FullRowSelect) 

ButtonGadget(#btnScreen, 410, 010, 080, 030, "多选", #PB_Button_Toggle)
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
            If GetGadgetState(#btnScreen)
               ;设置多选
               Style = GetWindowLong_(GadgetID(#lstScreen), #GWL_STYLE) 
               NewStyle = Style & ~#PB_ListIcon_MultiSelect
               SetWindowLong_(GadgetID(#lstScreen), #GWL_STYLE, NewStyle) 
            Else
               ;取消多选
               Style = GetWindowLong_(GadgetID(#lstScreen), #GWL_STYLE) 
               NewStyle = Style | #PB_ListIcon_MultiSelect
               SetWindowLong_(GadgetID(#lstScreen), #GWL_STYLE, NewStyle) 

            EndIf 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; FirstLine = 14
; EnableXP
; EnableUnicode