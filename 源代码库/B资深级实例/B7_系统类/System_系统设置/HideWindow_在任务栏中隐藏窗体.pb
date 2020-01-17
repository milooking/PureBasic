;***********************************
;迷路仟整理 2019.03.15
;HideWindow_在任务栏中隐藏窗体
;***********************************


Enumeration
   #winScreen
   #winAssist
   #btnScreen
EndEnumeration

Procedure Taskbar_HideWindow(WindowID, hWindowNew, show) 
   If Show = #True
      HideWindow(WindowID,#True) 
   EndIf 
   SetWindowLong_(WindowID(WindowID),#GWL_HWNDPARENT, hWindowNew) 
   If Show = #True 
      HideWindow(WindowID,#False) 
   EndIf 
   ProcedureReturn 
EndProcedure 

hWindow = OpenWindow(#winAssist, 0, 0, 0, 0, "辅助窗体", #PB_Window_ScreenCentered) 
HideWindow(#winAssist, #True) 

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
OpenWindow(#winScreen, 0, 0, 400, 250, "HideWindow_在任务栏中隐藏窗体", WindowFlags)
ButtonGadget(#btnScreen, 100, 100, 200, 040, "隐藏任务栏中的窗体", #PB_Button_Toggle) 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Select EventGadget() 
            Case #btnScreen
               If GetGadgetState(#btnScreen)
                  Taskbar_HideWindow(#winScreen, hWindow, #False) 
                  SetGadgetText(#btnScreen, "显示任务栏中的窗体")
               Else     
                  Taskbar_HideWindow(#winScreen, #Null, #True) 
                  SetGadgetText(#btnScreen, "隐藏任务栏中的窗体")
               EndIf 
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = 0
; EnableXP
; EnableOnError