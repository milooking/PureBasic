;***********************************
;迷路仟整理 2019.01.29
;ClearConsole_清空控制台
;***********************************

For i = 1 To 4
   If OpenConsole()
      PrintN("第 #"+Str(i)+" 次打开控制台!")
      PrintN("按[回车键]可以退出!")
      Input()
      CloseConsole()
   EndIf
Next










; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP