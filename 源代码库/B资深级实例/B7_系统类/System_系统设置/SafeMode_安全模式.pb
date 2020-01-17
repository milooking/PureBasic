;***********************************
;迷路仟整理 2019.03.15
;SafeMode_安全模式
;***********************************


Procedure DetectSafeMode() 
   ProcedureReturn GetSystemMetrics_(#SM_CLEANBOOT) 
EndProcedure 

Select DetectSafeMode() 
   Case 0 
      Debug "系统是正常模式下启动." 
   Case 1 
      Debug "系统以安全模式启动." 
   Case 2 
      Debug "系统以安全模式(带网络)启动" 
EndSelect 

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; Folding = -
; EnableXP
; EnableOnError