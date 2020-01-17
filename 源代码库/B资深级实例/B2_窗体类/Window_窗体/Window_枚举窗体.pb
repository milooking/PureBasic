;***********************************
;迷路仟整理 2019.03.14
;Window_枚举窗体
;***********************************


#winScreen = 0

; 枚举模拟器窗口
Procedure Enum_Window(hWindow, Index)  
   Title$ = Space(255)  
   GetWindowText_(hWindow, @Title$, 255) 
   If FindString(Title$, "PureBasic", 1)
      Debug "窗体句柄: 0x" + Hex(hWindow)
      Debug "窗体名称: "   + Title$
      Debug ""
;       ProcedureReturn #false ;找到一个后退出
      ProcedureReturn #True ;枚举全部
   Else  
      ProcedureReturn #True  
   EndIf  
EndProcedure 



WindowFlags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "Window_枚举窗体",  WindowFlags)

EnumWindows_(@Enum_Window(), 0)
Repeat
   EventNum = WindowEvent()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; Folding = -
; EnableXP