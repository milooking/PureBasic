;***********************************
;迷路仟整理 2019.03.28
;Mutex_只运行一个窗体
;***********************************

#ERROR_ALREADY_EXISTS = 183
Global WM_ACTIVATEOLDINST
WM_ACTIVATEOLDINST = RegisterWindowMessage_("WM_ACTIVATEOLDINST_PB")
MutexName$ = "只能运行一个窗口"

Enumeration
   #WinScreen
EndEnumeration

Procedure Window_Callback(WindowID, message, wParam, lParam)
   Result = #PB_ProcessPureBasicEvents
   If Message = WM_ACTIVATEOLDINST
      ShowWindow_(WindowID, #SW_RESTORE)
      SetForegroundWindow_(WindowID)
   EndIf
   ProcedureReturn Result
EndProcedure

hMutex = CreateMutex_(0, 0, @MutexName$)
If GetLastError_() = #ERROR_ALREADY_EXISTS
   SendMessage_(#HWND_BROADCAST, WM_ACTIVATEOLDINST, 0, 0)
   End
EndIf

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "只能运行一个窗口", WindowFlags)

    
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End

If hMutex <> 0  
   CloseHandle_(hMutex)  
EndIf  
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 42
; FirstLine = 6
; Folding = -
; EnableXP
; EnableOnError
; Executable = 只能运行一个窗口.exe