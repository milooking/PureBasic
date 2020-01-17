;***********************************
;迷路仟整理 2019.01.28
;Threaded_全局线程变量
;***********************************
;支持变量,链表,映射

Threaded Counter
Counter = 128       ;这里的Counter和Threaded中的Counter是不一样的变量
  
Procedure Thread(Parameter)
   Debug Counter       ; 当这个线程还没有使用这个变量时，会显示0
   Counter = Parameter
   Debug Counter       ; 显示256
EndProcedure
  
ThreadID = CreateThread(@Thread(), 256)
WaitThread(ThreadID)    ;等待线程结束
Debug Counter          ;这里显示128(即使在线程中更改了计数器)


Debug ""
Threaded _Counter = 128 ; 全局变量并赋值

Procedure Thread2(Parameter)
   Debug _Counter      ; 当这个线程还没有使用这个变量时，会显示128
   _Counter = Parameter
   Debug _Counter      ; 显示256
EndProcedure
  
ThreadID = CreateThread(@Thread2(), 256)
WaitThread(ThreadID)    ;等待线程结束
Debug _Counter         ;这里显示128(即使在线程中更改了计数器)





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = -
; EnableXP