;***********************************
;迷路仟整理 2019.01.15
;隐藏工具栏
;***********************************


#winScreen = 0
#wtbScreen = 0
#btnScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "隐藏工具栏", WindowFlags)

hToolbar = CreateToolBar(#wtbScreen, hWindow)
If hToolbar
   ToolBarStandardButton(0, #PB_ToolBarIcon_New,  #PB_ToolBar_Toggle)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open, #PB_ToolBar_Toggle)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save, #PB_ToolBar_Toggle)
EndIf

ButtonGadget(#btnScreen, 150, 110, 100, 30, "隐藏", #PB_Button_Toggle)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
         If EventGadget() = #btnScreen
            If GetGadgetState(#btnScreen)
               ShowWindow_(hToolbar, #SW_HIDE)
               SetGadgetText(#btnScreen,"显示")
            Else
               ShowWindow_(hToolbar, #SW_SHOWNORMAL)
               SetGadgetText(#btnScreen,"隐藏")
            EndIf
         EndIf
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP