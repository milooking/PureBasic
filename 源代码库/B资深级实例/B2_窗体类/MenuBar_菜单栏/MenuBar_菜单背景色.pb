;***********************************
;迷路仟整理 2019.01.16
;菜单背景色
;***********************************


Structure __MENUINFO
  cbSize.l
  fMask.l
  dwStyle.l
  cyMax.l
  hbrBack.i
  dwContextHelpID.l
  dwMenuData.l
EndStructure



#winScreen = 0
#wmpScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单背景色", WindowFlags)

If CreatePopupMenu(#wmpScreen)
   MenuItem( 1, "剪切(&X)")     
   MenuItem( 2, "复制(&C)")
   MenuItem( 3, "保存(&V)")
   MenuBar()
   MenuItem( 7, "退出(&Q)")
EndIf

#MIM_BACKGROUND = $2
#MIM_APPLYTOSUBMENUS = $80000000
hBrush = CreateSolidBrush_(RGB(255,255,200))
Style.__MENUINFO
Style\cbSize  = SizeOf(__MENUINFO)
Style\fMask   = #MIM_BACKGROUND|#MIM_APPLYTOSUBMENUS
Style\hbrBack = hBrush  
  
SetMenuInfo_(MenuID(#wmpScreen), @Style)  
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
; CursorPosition = 5
; Folding = -
; EnableXP