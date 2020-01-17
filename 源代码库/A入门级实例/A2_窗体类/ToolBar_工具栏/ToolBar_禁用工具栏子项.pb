;***********************************
;迷路仟整理 2019.01.15
;禁用工具栏子项
;***********************************

#winScreen = 0
#wtbScreen = 0
#btnScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "禁用工具栏子项", WindowFlags)

If CreateToolBar(#wtbScreen, hWindow)
   ToolBarStandardButton(0, #PB_ToolBarIcon_New,  #PB_ToolBar_Toggle)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open, #PB_ToolBar_Toggle)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save, #PB_ToolBar_Toggle)
   DisableToolBarButton(#wtbScreen, 1, 1)
EndIf

ButtonGadget(#btnScreen, 150, 110, 100, 30, "启用", #PB_Button_Toggle)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
         If EventGadget() = #btnScreen
            If GetGadgetState(#btnScreen)
               DisableToolBarButton(#wtbScreen, 1, 0)
               SetGadgetText(#btnScreen,"禁用")
            Else
               DisableToolBarButton(#wtbScreen, 1, 1)
               SetGadgetText(#btnScreen,"启用")
            EndIf
         EndIf

   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; EnableXP