;***********************************
;迷路仟整理 2019.01.26
;CreateMutex_线程互锁2
;***********************************

Global _MutexID

Procedure Thread_Mutex(Index)
   For i = 1 To 3  
      LockMutex(_MutexID)        ;锁定线程,起独占作用
      PrintN("============ 华丽的分隔线 ============")
      PrintN("[线程-"+Str(Index)+"]: 第" +Str(i) + "次, 每次显示3行,共显示3次:")
      For j = 1 To 3
        Delay(100)
        PrintN("[Thread-"+Str(Index)+"] Line "+Str(j))
      Next  
      UnlockMutex(_MutexID)      ;解锁线程
      Delay(100)                 ;让For有时间间隔,以切换到另一线程中,起被动锁定作用
   Next  
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
; [Thread-1] Line 1
; [Thread-1] Line 2
; [Thread-1] Line 3
; ============ 华丽的分隔线 ============
; [线程-2]: 第1次, 每次显示3行,共显示3次:
; [Thread-2] Line 1
; [Thread-2] Line 2
; [Thread-2] Line 3
; ============ 华丽的分隔线 ============
; [线程-3]: 第1次, 每次显示3行,共显示3次:
; [Thread-3] Line 1
; [Thread-3] Line 2
; [Thread-3] Line 3

; ============ 华丽的分隔线 ============
; [线程-1]: 第2次, 每次显示3行,共显示3次:
; [Thread-1] Line 1
; [Thread-1] Line 2
; [Thread-1] Line 3
; ============ 华丽的分隔线 ============
; [线程-2]: 第2次, 每次显示3行,共显示3次:
; [Thread-2] Line 1
; [Thread-2] Line 2
; [Thread-2] Line 3
; ============ 华丽的分隔线 ============
; [线程-3]: 第2次, 每次显示3行,共显示3次:
; [Thread-3] Line 1
; [Thread-3] Line 2
; [Thread-3] Line 3

; ============ 华丽的分隔线 ============
; [线程-1]: 第3次, 每次显示3行,共显示3次:
; [Thread-1] Line 1
; [Thread-1] Line 2
; [Thread-1] Line 3
; ============ 华丽的分隔线 ============
; [线程-2]: 第3次, 每次显示3行,共显示3次:
; [Thread-2] Line 1
; [Thread-2] Line 2
; [Thread-2] Line 3
; ============ 华丽的分隔线 ============
; [线程-3]: 第3次, 每次显示3行,共显示3次:
; [Thread-3] Line 1
; [Thread-3] Line 2
; [Thread-3] Line 3


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; FirstLine = 6
; Folding = -
; EnableThread
; EnableXP