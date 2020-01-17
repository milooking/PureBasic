;***********************************
;迷路仟整理 2019.01.26
;WaitThread_线程等待
;***********************************

Procedure Thread_Print(Value)
   For Index = 1 To 10
      PrintN("线程计数: " + Str(Index))
      Delay(Value)
   Next 
EndProcedure
  
If OpenConsole()
   ThreadID = CreateThread(@Thread_Print(), 1000)  ;设置线程计算间隔时间为1000ms
   If ThreadID
      WaitThread(ThreadID)    ;这里要等待线程Thread_Print()运行结束后才往下运行
      For i = 0 To 10
         PrintN("进程计数: " + Str(i)+"<-------------")
         Delay(999)
      Next
   EndIf
EndIf
PrintN(" 程序运行结束,按[回车键]可以退出")
Input()


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; Folding = -
; EnableXP