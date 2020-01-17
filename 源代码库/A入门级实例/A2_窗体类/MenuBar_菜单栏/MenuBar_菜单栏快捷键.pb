;***********************************
;迷路仟整理 2019.01.16
;菜单栏快捷键
;***********************************


#winScreen = 0
#wmbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单栏快捷键: 按[ESC]退出", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")           
      MenuItem(1, "加载(&L)")      
      MenuItem(2, "保存(&S)")
      MenuItem(3, "另存为...")
      MenuBar()
      MenuItem(4, "退出(&Q)  [ESC]")
EndIf

AddKeyboardShortcut(#winScreen, #PB_Shortcut_Escape, 4)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         MenuID = EventMenu() 
         Debug MenuID          
         If MenuID = 4 : IsExitWindow = #True : EndIf 

   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; FirstLine = 5
; EnableXP