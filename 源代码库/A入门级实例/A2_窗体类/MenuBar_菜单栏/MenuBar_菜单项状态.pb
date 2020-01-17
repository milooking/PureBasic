;***********************************
;迷路仟整理 2019.01.16
;菜单项状态
;***********************************


#winScreen = 0
#wmbScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单项状态", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("窗体(&W)")        
      MenuItem( 1, "置顶")  
EndIf


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         If EventMenu() = 1
            State = GetMenuItemState(#wmbScreen, 1)
            Debug "[置顶]项状态: "+Str(State)
            SetMenuItemState(#wmbScreen, 1, 1-State)
            StickyWindow(#winScreen, 1-State)
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; EnableXP