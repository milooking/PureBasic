;***********************************
;迷路仟整理 2019.02.03
;SetCursor_设置光标效果
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
EndEnumeration

Procedure Event_MoveOnGadget(hWindow)
   GetCursorPos_(Mouse.POINT) 
   MapWindowPoints_(0, hWindow, Mouse, #True) 
   ProcedureReturn ChildWindowFromPoint_(hWindow, Mouse\y<<32|Mouse\x) 
EndProcedure

;获取光标
hCursor1 = LoadCursor_(0, #IDC_CROSS) 
hCursor2 = LoadCursor_(0, #IDC_WAIT) 
hCursor3 = LoadCursor_(0, #IDC_HELP) 
hCursor4 = LoadCursor_(0, #IDC_NO) 


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "设置光标效果", WindowFlags)

hGadget1 = ButtonGadget(#btnScreen1, 030, 050, 150, 050, "十字效果")
hGadget2 = ButtonGadget(#btnScreen2, 030, 120, 150, 050, "等待效果")
hGadget3 = ButtonGadget(#btnScreen3, 220, 050, 150, 050, "帮助效果")
hGadget4 = ButtonGadget(#btnScreen4, 220, 120, 150, 050, "禁止效果")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MOUSEMOVE
         hGadget = Event_MoveOnGadget(hWindow)
         Select hGadget
            Case hGadget1 : SetCursor_(hCursor1)
            Case hGadget2 : SetCursor_(hCursor2)
            Case hGadget3 : SetCursor_(hCursor3)
            Case hGadget4 : SetCursor_(hCursor4)
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
;释放光标
DestroyCursor_(hCursor1) 
DestroyCursor_(hCursor2) 
DestroyCursor_(hCursor3) 
DestroyCursor_(hCursor4) 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; FirstLine = 12
; Folding = 0
; EnableXP
; EnableOnError