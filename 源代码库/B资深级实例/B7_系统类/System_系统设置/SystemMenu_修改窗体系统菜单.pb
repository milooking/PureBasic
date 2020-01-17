;***********************************
;迷路仟整理 2019.03.15
;SystemMenu_修改窗体系统菜单
;***********************************


Enumeration
   #winScreen
   #lblScreen
   #mniHomePage
   #mniLanguage
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "SystemMenu_修改窗体系统菜单", WindowFlags)
TextGadget(#lblScreen, 010, 010, 380, 015, "右键点击窗体左上角非客户区,弹出菜单最后两个选项是自定义的.")
hSysMenu = GetSystemMenu_(hWindow, #False) 
DeleteMenu_(hSysMenu, 1, #MF_BYPOSITION) 
AppendMenu_(hSysMenu, #MF_STRING, #mniHomePage, "PureBasic官网") 
AppendMenu_(hSysMenu, #MF_STRING, #mniLanguage, "关于PureBasic...") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
         
      Case #WM_SYSCOMMAND 
      Select EventwParam() 
        Case #mniHomePage: 
            ShellExecute_(hWnd, "Open", "https://www.purebasic.com/index.php", "", "", 1) 
        Case #mniLanguage: 
            MessageRequester("提示", "PureBasic 是一门假装是B系的语言.", 0) 
      EndSelect 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP
; EnableOnError