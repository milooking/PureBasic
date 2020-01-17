;***********************************
;迷路仟整理 2019.01.29
;ClearConsole_清空控制台
;***********************************

If OpenConsole()                    ;打开控制台
    PrintN("测试内容")
    Delay(3000)
    ClearConsole()                  ;清空控制台
    PrintN("按[回车键]可以退出!")
    Input()                         ;等待输出
EndIf










; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; EnableXP