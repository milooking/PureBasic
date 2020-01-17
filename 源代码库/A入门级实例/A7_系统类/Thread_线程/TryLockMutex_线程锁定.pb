;***********************************
;迷路仟整理 2019.01.26
;TryLockMutex_线程锁定(非阻塞)
;***********************************

; TryLockMutex() 与 LockMutex() 一样,用于锁定线程,
; 不同的是,执行TryLockMutex()后,无论成功还是失败,都会继续执行后续代码,
; 而要一直等待到LockMutex()到锁定成功,才会执行后续代码
; LockMutex(): 非阻塞锁定
; TryLockMutex(): 非阻塞锁定


Global _MutexID

Procedure Thread_Mutex(Index)
   For i = 1 To 10  
      If TryLockMutex(_MutexID)  ;尝试锁定线程,如果成功就执行
         PrintN("============ 华丽的分隔线 ============")
         PrintN("[线程-"+Str(Index)+"]: 第" +Str(i) + "次")
         UnlockMutex(_MutexID)      ;解锁线程
         Delay(100)                 ;让For有时间间隔,以切换到另一线程中,起被动锁定作用
      Else 
        PrintN("继续尝试锁定...")
        Delay(100)
      EndIf 
   Next  
EndProcedure

OpenConsole()
_MutexID  = CreateMutex()      ;创建进程锁
ThreadID1 = CreateThread(@Thread_Mutex(), 1)
ThreadID2 = CreateThread(@Thread_Mutex(), 2)
ThreadID3 = CreateThread(@Thread_Mutex(), 3)
Input()
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; Folding = +
; EnableThread
; EnableXP
; Executable = F:\桌面\XZX.exe