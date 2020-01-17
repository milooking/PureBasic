;***********************************
;迷路仟整理 2019.01.16
;菜单栏演示
;***********************************


#winScreen = 0
#wmbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单栏演示", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")           ;中文菜单名时:(&F): 按Alt+F可以打开[文件菜单项]
      MenuItem(1, "加载(&L)")      ;中文菜单名时:(&L): 按F可以打开[加载菜单项]
      MenuItem(2, "保存(&S)")
      MenuItem(3, "另存为...")
      MenuBar()
      MenuItem(4, "退出(&Q)")
      
   MenuTitle("&Edit")              ;英文菜单名时:&Edit: 按Alt+E可以打开[Edit菜单项]
      MenuItem(5, "&Cut")          ;英文菜单名时:&Cut:  按C可以打开[Cut菜单项]
      MenuItem(6, "Cop&y")         ;英文菜单名时:Cop&y: 按Y可以打开[Copy菜单项]
      MenuItem(7, "&Paste")        ;英文菜单名时:&Paste:  按P可以打开[Paste菜单项]
      
   MenuTitle("?")
      MenuItem(8, "帮助")

EndIf

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; FirstLine = 6
; EnableXP