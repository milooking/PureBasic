;***********************************
;迷路仟整理 2019.01.15
;查找窗体
;***********************************

Procedure.l EnumProcedure(WindowHandle.l, Parameter.l)  
   Title$ = Space(255)  
   GetWindowText_(WindowHandle, @Title$, 200)  
   If FindString(Title$, "PureBasic", 1) <> 0  
      MessageRequester("","找到窗体了: "+ Title$)  
      ProcedureReturn 0  
   Else  
      ProcedureReturn 1  
   EndIf  
EndProcedure  
  
EnumWindows_(@EnumProcedure(), 0) 




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP