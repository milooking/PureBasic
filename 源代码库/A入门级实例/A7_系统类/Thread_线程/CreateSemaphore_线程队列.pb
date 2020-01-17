;***********************************
;迷路仟整理 2019.01.26
;CreateSemaphore_线程队列
;***********************************

Global SemaphoreID 
Global MutexID 
Global NewList ListQueue$()

Procedure Producer(Total)
   For i = 1 To Total
      Delay(Random(99,25))
    ; 队列访问需要一个互斥锁来保证线程安全
      LockMutex(MutexID)
         LastElement(ListQueue$())
         AddElement(ListQueue$())
         ListQueue$() = Str(i)
      UnlockMutex(MutexID)    
      ;发出有一个队列信号, 让WaitSemaphore()可以运行到下一步.
      If i % 3 = 0
         SignalSemaphore(SemaphoreID) 
      EndIf  
   Next
EndProcedure

SemaphoreID = CreateSemaphore()
MutexID = CreateMutex()

If CreateThread(@Producer(), 10*3)
   For i = 1 To 10  
      WaitSemaphore(SemaphoreID)   ;等待一个队列信息,直到触发时SignalSemaphore()才执行下一步
      LockMutex(MutexID)           ;锁住线程,等显示完了,再让线程继续运行
      Queue$ = "队列:"             ;显示队列状态
      ForEach ListQueue$()
         Queue$ + " " + RSet(ListQueue$(), 2, "0")
      Next
      Debug Queue$
      UnlockMutex(MutexID)         ;解锁线程
   Next i

EndIf


; 显示效果
; 队列: 01 02 03
; 队列: 01 02 03 04 05 06
; 队列: 01 02 03 04 05 06 07 08 09
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
; 队列: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 54
; FirstLine = 30
; Folding = -
; EnableXP