;***********************************
;迷路仟整理 2019.01.26
;CreateThread_创建线程
;***********************************

;线程函数必须也只能带一个参数,参数可以是整型数据,也可以是指针(内存指针,结构指针)
;线程需要用CreateThread()来创建,第一个参数是线程函数,第二个参数是线程函数的参数
;线程函数命名时,建议以Thread_做开头,以示区分,

Procedure Thread_Test(Value)
   Debug "Value = " + Str(Value) ;Value = CreateThread(@AlertThread(), 123)中的123
   Repeat
      CountTime+1
      Debug "计时: " +FormatDate("%HH:%II:%SS", CountTime)
      Delay(1000)
   ForEver
EndProcedure

ThreadID = CreateThread(@Thread_Test(), 123)

MessageRequester("提示", "每隔1秒,线程会Debug一下."+#LF$+"点击,可以结束这个程序", 0) 




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; Folding = -
; EnableXP