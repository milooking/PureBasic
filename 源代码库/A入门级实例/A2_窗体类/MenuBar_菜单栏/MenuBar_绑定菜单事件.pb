;***********************************
;迷路仟整理 2019.01.16
;绑定菜单事件
;***********************************


#winScreen = 0
#wmbScreen = 0
#btnScreen = 0

Procedure EventMenu_BindTest()
    Debug "绑定菜单事件成功! " + EventMenu()
EndProcedure


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "绑定菜单事件", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")           ;中文菜单名时:(&F): 按Alt+F可以打开[文件菜单项]
      MenuItem( 1, "加载(&L)")     ;中文菜单名时:(&L): 按F可以打开[加载菜单项]
      MenuItem( 2, "保存(&S)")
      MenuItem( 3, "另存为...")
      MenuBar()
      OpenSubMenu("最近打开(&N)")
         MenuItem( 5, "测试.png")
         MenuItem( 6, "测试.tga")
      CloseSubMenu()
      MenuBar()
      MenuItem( 7, "退出(&Q)")

EndIf
  
ButtonGadget(#btnScreen, 150, 120, 100, 30, "绑定菜单事件", #PB_Button_Toggle)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            If GetGadgetState(#btnScreen)
               SetGadgetText(#btnScreen, "解绑菜单事件")
               For MenuID = 1 To 7
                  BindMenuEvent(#wmbScreen, MenuID, @EventMenu_BindTest())
               Next 
            Else
               SetGadgetText(#btnScreen, "绑定菜单事件")
               For MenuID = 1 To 7
                  UnbindMenuEvent(#wmbScreen, MenuID, @EventMenu_BindTest())
               Next 
            EndIf
         EndIf
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; Folding = -
; EnableXP