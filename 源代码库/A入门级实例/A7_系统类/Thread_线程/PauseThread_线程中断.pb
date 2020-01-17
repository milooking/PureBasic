;***********************************
;迷路仟整理 2019.01.26
;PauseThread_线程中断
;***********************************

Procedure Thread_Print(Value)
   Repeat
      Count + 1
      PrintN("线程计数: " + Str(Count))
      Delay(Value)
   ForEver
EndProcedure


If OpenConsole()
   ThreadID = CreateThread(@Thread_Print(), 100)  ;设置线程计算间隔时间为100ms
   If ThreadID
      Delay(999)
      PrintN(" ****** 暂停线程 ****** ")
      PauseThread(ThreadID)   ;这里对线程Thread_Print()进行暂停操作,然后继续下面的代码
      For i = 0 To 10
         PrintN("进程计数: " + Str(i)+"<-------------")
         Delay(999)
      Next
      PrintN(" ****** 恢复线程 ****** ")
      ResumeThread(ThreadID)  ;这里对线程Thread_Print()进行恢复操作,然后继续下面的代码
   EndIf
EndIf
Delay(3000)



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; FirstLine = 5
; Folding = -
; EnableXP