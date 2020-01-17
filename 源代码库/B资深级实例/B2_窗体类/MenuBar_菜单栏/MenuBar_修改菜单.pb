;***********************************
;迷路仟整理 2019.01.16
;修改菜单标题
;***********************************


#winScreen = 0
#wmbScreen = 1
#txtScreen = 2
#btnScreen = 3

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "修改菜单", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")       
      MenuItem(1, "加载(&L)")  
      MenuItem(2, "保存(&S)")
      MenuItem(3, "另存为...")
      MenuBar()
      MenuItem(4, "退出(&Q)")
      
   MenuTitle("编辑(&E)") 
      MenuItem(5, "剪切")  
      MenuItem(6, "复制")   
      MenuItem(7, "粘贴")  
EndIf


StringGadget(#txtScreen, 150, 095, 100, 20, "菜单名")
ButtonGadget(#btnScreen, 150, 120, 100, 30, "修改")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            MenuTitle$ = GetGadgetText(#txtScreen)
;             ModifyMenu_(MenuID(#wmbScreen), 1,  #MF_BYCOMMAND, 1, MenuTitle$)  ;修改菜单项
            ModifyMenu_(MenuID(#wmbScreen), 1,  #MF_BYPOSITION, 1, MenuTitle$)   ;修改菜单组
            DrawMenuBar_(hWindow)  
         EndIf
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; EnableXP