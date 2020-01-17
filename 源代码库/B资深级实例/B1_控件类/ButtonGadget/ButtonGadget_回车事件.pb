;***********************************
;迷路仟整理 2019.01.15
;响应回车事件
;***********************************

Enumeration
   #WinScreen
   #btnScreen
   #mniScreen
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 430, 250, "响应回车事件", WindowFlags)

hGadget = ButtonGadget(#btnScreen, 150, 100, 100, 35, "响应回车键")
AddKeyboardShortcut(#WinScreen, #PB_Shortcut_Return, #mniScreen)  
    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug "鼠标事件"
      Case #PB_Event_Menu 
          Select EventMenu()  
            Case #mniScreen  
               Debug "回车事件"
          EndSelect  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 30
; FirstLine = 7
; Folding = -
; EnableXP