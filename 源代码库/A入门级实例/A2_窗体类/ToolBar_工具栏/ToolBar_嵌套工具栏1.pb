;***********************************
;迷路仟整理 2019.01.15
;嵌套工具栏,在控件中嵌套工具栏
;***********************************


Enumeration
   #winScreen
   #frmScreen
   #wtbScreen 
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "嵌套工具栏1", WindowFlags)

hGadget = ContainerGadget(#frmScreen, 100, 100, 200, 50) 
hToolbar = CreateToolBar(#wtbScreen, hGadget)
If hToolbar
   ToolBarStandardButton(0, #PB_ToolBarIcon_New,  #PB_ToolBar_Toggle)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open, #PB_ToolBar_Toggle)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save, #PB_ToolBar_Toggle)
EndIf
CloseGadgetList()

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
; CursorPosition = 19
; Folding = -
; EnableXP