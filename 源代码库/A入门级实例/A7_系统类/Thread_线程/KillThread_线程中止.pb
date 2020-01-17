;***********************************
;迷路仟整理 2019.01.26
;KillThread_线程中止
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
      For i = 0 To 10
         PrintN("进程计数: " + Str(i)+"<-------------")
         Delay(999)
         If i = 5
            KillThread(ThreadID)
            PrintN(" ****** 中止线程: " + Str(i)+" ****** ")
         EndIf
      Next
   EndIf
EndIf
PrintN(" 程序运行结束,按[回车键]可以退出")
Input()


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = -
; EnableXP