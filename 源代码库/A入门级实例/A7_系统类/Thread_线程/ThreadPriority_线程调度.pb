;***********************************
;迷路仟整理 2019.01.26
;ThreadPriority_线程调度
;***********************************

;注明: 作用不是很明显,期待后续版本提升性能
; Priority = 1:最低
; Priority = 2至15:低于正常水平
; Priority = 16:正常
; Priority = 17至30:高于正常水平
; Priority = 31: 最高水平
; Priority = 32: 特急

Procedure Thread_Print(Index)
   For i = 1 To 10000000   ;根据自己的电脑性能调整大小.
      ;暴力空运行
   Next 
   PrintN("线程-"+Str(Index)+"完成")
EndProcedure
  
If OpenConsole()
   ThreadID1 = CreateThread(@Thread_Print(), 1)
   ThreadID2 = CreateThread(@Thread_Print(), 2)
   ThreadID3 = CreateThread(@Thread_Print(), 3)


   ThreadPriority(ThreadID1, 17) ;居中
   ThreadPriority(ThreadID2, 02) ;最低
   ThreadPriority(ThreadID3, 32) ;最优先
   PrintN("程序运行结束,按[回车键]可以退出")
   Input()
EndIf














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = +
; EnableThread
; EnableXP
; Executable = F:\桌面\XZX.exe