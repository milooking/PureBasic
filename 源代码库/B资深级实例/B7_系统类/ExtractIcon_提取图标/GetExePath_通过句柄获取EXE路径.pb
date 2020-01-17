;***********************************
;迷路仟整理 2019.03.15
;GetExePath_通过句柄获取EXE路径
;***********************************
Prototype.i GetModuleFileNameExW(hProcess.l,hModule.l,*lpFilename,nSize.i)
Global GetModuleFileNameEx.GetModuleFileNameExW

Enumeration
   #winScreen
EndEnumeration

; 枚举EXE路径
Procedure$ GetWindowExePath(hWindow)
   LibraryID = OpenLibrary(#PB_Any,"psapi.dll")
   If LibraryID
      GetModuleFileNameEx.GetModuleFileNameExW = GetFunction(LibraryID,"GetModuleFileNameExW")
      ExeFullName$ = Space(1024)
      GetWindowThreadProcessId_(hWindow, @hProcessId)   
      hHandle = OpenProcess_(#PROCESS_ALL_ACCESS, 0, hProcessId) 
      If hHandle
         GetModuleFileNameEx(hHandle, 0, @ExeFullName$, 1024) 
         CloseHandle_(hHandle)
      EndIf   
      CloseLibrary(LibraryID)
   EndIf
   ProcedureReturn ExeFullName$
EndProcedure



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "GetExePath_通过句柄获取EXE路径", WindowFlags)

Debug GetWindowExePath(hWindow)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; Folding = -
; EnableXP
; EnableOnError