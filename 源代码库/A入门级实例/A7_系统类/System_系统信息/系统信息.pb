;***********************************
;迷路仟整理 2019.01.25
;获取系统信息
;***********************************


Debug "计算机用户: "+ UserName()
Debug "计算机名称: "+ ComputerName()
Debug "CPU 内核数: "+ Str(CountCPUs())+"个"
Debug "物理内存  : "+ StrF(MemoryStatus(#PB_System_TotalPhysical) / (1024 * 1024 * 1024), 2) + " GB"
Debug "系统版本  : "+  OSVersion()


;   #PB_OS_Windows_NT3_51
;   #PB_OS_Windows_95
;   #PB_OS_Windows_NT_4
;   #PB_OS_Windows_98
;   #PB_OS_Windows_ME
;   #PB_OS_Windows_2000
;   #PB_OS_Windows_XP
;   #PB_OS_Windows_Server_2003
;   #PB_OS_Windows_Vista
;   #PB_OS_Windows_Server_2008
;   #PB_OS_Windows_7
;   #PB_OS_Windows_Server_2008_R2
;   #PB_OS_Windows_8
;   #PB_OS_Windows_Server_2012
;   #PB_OS_Windows_8_1
;   #PB_OS_Windows_Server_2012_R2
;   #PB_OS_Windows_10
;   #PB_OS_Windows_Future 




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; EnableXP