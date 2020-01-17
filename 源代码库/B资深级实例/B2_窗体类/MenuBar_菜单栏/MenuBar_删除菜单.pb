;***********************************
;迷路仟整理 2019.01.16
;删除菜单
;***********************************


#winScreen = 0
#wmbScreen = 1
#btnScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "删除菜单", WindowFlags)

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

ButtonGadget(#btnScreen, 150, 110, 100, 30, "删除", #PB_Button_Toggle)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            MenuTitle$ = GetGadgetText(#txtScreen)
            DeleteMenu_(MenuID(#wmbScreen), 1, #MF_BYPOSITION)   ;菜单组
;             DeleteMenu_(MenuID(#wmbScreen), 1, #MF_BYCOMMAND)   ;菜单项
            DrawMenuBar_(hWindow)  
         EndIf
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP