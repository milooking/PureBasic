;***********************************
;迷路仟整理 2019.03.15
;获取磁盘大小
;***********************************

Procedure GetDiskSize(Drive$)
   SetErrorMode_(#SEM_FAILCRITICALERRORS) 
   If GetDiskFreeSpaceEx_(@Drive$, @BytesFreeToCaller.q, @TotalBytes.q, @TotalFreeBytes.q) = 0 
      MessageRequester("出错","磁盘不存在!") 
      End 
   EndIf 
   SetErrorMode_(0) 
   Debug "磁  盘: "+Drive$ 
   Debug "总大小: "+Str(TotalBytes>>20)+" Mb" 
   Debug "未使用: "+Str(TotalFreeBytes>>20)+" Mb" 
EndProcedure

GetDiskSize("C:\")
GetDiskSize("D:\")
GetDiskSize("E:\")
GetDiskSize("F:\")



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; Folding = -
; EnableXP
; EnableOnError