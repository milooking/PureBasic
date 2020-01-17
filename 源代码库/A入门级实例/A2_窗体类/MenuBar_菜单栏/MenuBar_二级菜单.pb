;***********************************
;迷路仟整理 2019.01.16
;二级菜单
;***********************************


#winScreen = 0
#wmbScreen = 1
#wmpScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "二级菜单", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")       
      MenuItem( 1, "加载(&L)")  
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

If CreatePopupMenu(#wmpScreen)
   MenuItem( 1, "剪切(&X)")     
   MenuItem( 2, "复制(&C)")
   MenuItem( 3, "保存(&V)")
   MenuBar()
   OpenSubMenu("最近打开(&N)")
      MenuItem( 5, "测试.png")
      MenuItem( 6, "测试.tga")
   CloseSubMenu()
   MenuBar()
   MenuItem( 7, "退出(&Q)")
EndIf


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
; CursorPosition = 43
; FirstLine = 26
; EnableXP