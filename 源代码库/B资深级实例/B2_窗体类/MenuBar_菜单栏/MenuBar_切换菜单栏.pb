;***********************************
;迷路仟整理 2019.01.16
;菜单项状态
;***********************************


#winScreen = 0
#wmbScreen1 = 1
#wmbScreen2 = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "切换菜单栏", WindowFlags)

If CreateMenu(#wmbScreen1, hWindow)
   MenuTitle("菜单A")        
      MenuItem(11, "菜单项") 
   MenuTitle("切换至样式B")
      MenuItem(12, "切换")
EndIf

If CreateMenu(#wmbScreen2, hWindow)
   MenuTitle("菜单B")        
      MenuItem(21, "菜单项") 
   MenuTitle("切换至样式A")
      MenuItem(22, "切换")
EndIf

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         Select EventMenu()
            Case 12 : SetMenu_(hWindow, MenuID(#wmbScreen2))  
            Case 22 : SetMenu_(hWindow, MenuID(#wmbScreen1))  
         EndSelect 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 6
; EnableXP