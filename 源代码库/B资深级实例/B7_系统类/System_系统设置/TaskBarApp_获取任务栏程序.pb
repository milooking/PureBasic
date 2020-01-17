;***********************************
;迷路仟整理 2019.03.15
;TaskBarApp_获取任务栏程序
;***********************************


Procedure ListWindows(Window, Parameter) 
   WindowClass$ = Space(255) 
   WindowTitle$ = Space(255) 
   GetClassName_(Window, WindowClass$, 255) 
   GetWindowText_(Window, WindowTitle$, 255) 
   If WindowTitle$ <> #Null$ And IsWindowVisible_(Window) 
      WindowTitle$ = ReplaceString(WindowTitle$, #LFCR$, "")
      Debug ":" + WindowTitle$ + " | " + WindowClass$ 
   EndIf 
   ProcedureReturn #True  
EndProcedure 

hTaskBar = FindWindow_("Shell_TrayWnd", 0) 
hMSTaskBar = FindWindowEx_(hTaskBar, 0, "MSTaskSwWClass", 0) 
EnumChildWindows_(hMSTaskBar, @ListWindows(), 0) 


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; Folding = -
; EnableXP
; EnableOnError