;***********************************
;迷路仟整理 2019.03.15
;KillProcess_关闭进程
;***********************************

Procedure KillProcess (Pid)  
   hProcess = OpenProcess_ (#PROCESS_TERMINATE, #False, Pid)  
   If hProcess <> #Null  
      If TerminateProcess_ (hProcess, 1)  
         Result = #True  
      EndIf  
      CloseHandle_ (hProcess)  
   EndIf  
   ProcedureReturn Result  
EndProcedure  

;PID可以到[Windows任务管理器]->[进程]查看要关闭进行的PID
;如果没显示PID, [查看(V)]->[选择列(S)...]->[PID (进程标识符)]打勾
Debug KillProcess (Pid)  




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP
; EnableOnError