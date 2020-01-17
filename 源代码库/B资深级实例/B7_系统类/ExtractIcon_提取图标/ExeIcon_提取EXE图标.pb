;***********************************
;迷路仟整理 2019.03.15
;ExtractIcon_提取图标
;***********************************

Enumeration
   #winScreen
   #picScreen
EndEnumeration

Procedure GetExeIcon()  
   hModule  = GetModuleHandle_(0)  
   Name$ = Space(1024)  
   GetModuleFileName_(0,Name$,1024)  
   hIcon = ExtractIcon_(hModule,Name$,0)  
   
   If hIcon  
      ProcedureReturn hIcon  
   Else  
      GetSystemDirectory_(Name$,1024)  
      ProcedureReturn ExtractIcon_(hModule, Name$+"\shell32.dll",2)  
   EndIf  
EndProcedure  


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ExtractIcon_提取图标", WindowFlags)

hIcon = GetExeIcon()
ImageGadget(#picScreen, 180, 100, 32, 32, hIcon)

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
; CursorPosition = 15
; Folding = -
; EnableXP
; EnableOnError