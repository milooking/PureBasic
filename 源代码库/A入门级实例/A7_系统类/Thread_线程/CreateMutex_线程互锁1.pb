;***********************************
;迷路仟整理 2019.01.26
;CreateMutex_线程互锁1
;***********************************

Global _MutexID

Procedure Thread_Mutex(Index)
   Shared _MutexID
   LockMutex(_MutexID)     ;锁定线程,只对本进程有效,跨进程无效
   PrintN("============ 华丽的分隔线 ============")
   For i = 1 To 3      
      PrintN("[线程-"+Str(Index)+"]: 第" +Str(i) + "次, 每次显示3行,共显示3次:")
      For j = 1 To 3
        Delay(100)
        PrintN("   [Thread-"+Str(Index)+"] Line "+Str(j))
      Next         
   Next  
   UnlockMutex(_MutexID)   ;解锁线程,记得解锁,否则会锁死其它线程
EndProcedure

  OpenConsole()
  _MutexID  = CreateMutex()      ;创建进程锁
  ThreadID1 = CreateThread(@Thread_Mutex(), 1) 
  ThreadID2 = CreateThread(@Thread_Mutex(), 2)
  ThreadID3 = CreateThread(@Thread_Mutex(), 3) 
  Input()
End

; 显示效果
; ============ 华丽的分隔线 ============
; [线程-1]: 第1次, 每次显示3行,共显示3次:
;    [Thread-1] Line 1
;    [Thread-1] Line 2
;    [Thread-1] Line 3
; [线程-1]: 第2次, 每次显示3行,共显示3次:
;    [Thread-1] Line 1
;    [Thread-1] Line 2
;    [Thread-1] Line 3
; [线程-1]: 第3次, 每次显示3行,共显示3次:
;    [Thread-1] Line 1
;    [Thread-1] Line 2
;    [Thread-1] Line 3
; ============ 华丽的分隔线 ============
; 
; [线程-3]: 第1次, 每次显示3行,共显示3次:
;    [Thread-3] Line 1
;    [Thread-3] Line 2
;    [Thread-3] Line 3
; [线程-3]: 第2次, 每次显示3行,共显示3次:
;    [Thread-3] Line 1
;    [Thread-3] Line 2
;    [Thread-3] Line 3
; [线程-3]: 第3次, 每次显示3行,共显示3次:
;    [Thread-3] Line 1
;    [Thread-3] Line 2
;    [Thread-3] Line 3
; ============ 华丽的分隔线 ============
; 
; [线程-2]: 第1次, 每次显示3行,共显示3次:
;    [Thread-2] Line 1
;    [Thread-2] Line 2
;    [Thread-2] Line 3
; [线程-2]: 第2次, 每次显示3行,共显示3次:
;    [Thread-2] Line 1
;    [Thread-2] Line 2
;    [Thread-2] Line 3
; [线程-2]: 第3次, 每次显示3行,共显示3次:
;    [Thread-2] Line 1
;    [Thread-2] Line 2
;    [Thread-2] Line 3


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; FirstLine = 6
; Folding = -
; EnableThread
; EnableXP