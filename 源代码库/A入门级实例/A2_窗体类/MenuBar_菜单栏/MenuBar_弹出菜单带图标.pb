;***********************************
;迷路仟整理 2019.01.16
;弹出菜单带图标
;***********************************


#winScreen = 0
#wmpScreen = 0
#imgScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "弹出菜单带图标", WindowFlags)

hImage = LoadImage(#imgScreen, "PureBasic.ico")
If CreatePopupImageMenu(#wmpScreen)
   MenuItem( 1, "剪切(&X)", hImage)     
   MenuItem( 2, "复制(&C)", hImage)
   MenuItem( 3, "保存(&V)", hImage)
   MenuBar()
   MenuItem( 7, "退出(&Q)", hImage)
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
; CursorPosition = 6
; EnableXP