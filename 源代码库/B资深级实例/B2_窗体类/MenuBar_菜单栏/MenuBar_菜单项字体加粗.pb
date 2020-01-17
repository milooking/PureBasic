;***********************************
;迷路仟整理 2019.01.16
;菜单项字体加粗
;***********************************


#winScreen = 0
#wmpScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单项字体加粗", WindowFlags)

If CreatePopupMenu(#wmpScreen)
   MenuItem( 1, "剪切(&X)")     
   MenuItem( 2, "复制(&C)")
   MenuItem( 3, "保存(&V)")
   MenuBar()
   MenuItem( 7, "退出(&Q)")
EndIf
  
Bold.MENUITEMINFO  
Bold\cbSize=SizeOf(MENUITEMINFO)  
Bold\hSubMenu = 2 
Bold\fMask =#MIIM_STATE  
Bold\fState=#MFS_DEFAULT  
SetMenuItemInfo_(MenuID(#wmpScreen), 1, #True, Bold) 
DrawMenuBar_(hWindow)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_RBUTTONUP :
          DisplayPopupMenu(#wmpScreen, hWindow)

      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP