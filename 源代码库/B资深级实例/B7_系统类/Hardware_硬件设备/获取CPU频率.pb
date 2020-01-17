;***********************************
;迷路仟整理 2019.03.15
;获取CPU频率
;***********************************


Procedure.l GetCpuMhz() 
  Global int64val.LARGE_INTEGER 
  !FINIT 
  !rdtsc 
  !MOV dword [v_int64val+4],Edx 
  !MOV dword [v_int64val],Eax 
  !FILD qword [v_int64val] 
  Delay(1000) 
  !rdtsc 
  !MOV dword [v_int64val+4],Edx 
  !MOV dword [v_int64val],Eax 
  !FILD qword [v_int64val] 
  !FSUBR st1,st0 
  int64val\HighPart=0 
  int64val\LowPart=1000000 
  !FILD qword [v_int64val] 
  !FDIVR st0,st2 
  !fistp qword [v_int64val] 
  ProcedureReturn int64val\LowPart 
EndProcedure 
  
Debug Str(GetCpuMhz()) + " Mhz"
Debug Str(GetCpuMhz()) + " Mhz"
Debug Str(GetCpuMhz()) + " Mhz"
Debug Str(GetCpuMhz()) + " Mhz"











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = +
; EnableXP
; EnableOnError