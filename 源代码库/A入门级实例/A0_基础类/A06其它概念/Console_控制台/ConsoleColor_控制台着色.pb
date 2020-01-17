;***********************************
;迷路仟整理 2019.01.29
;ClearConsole_清空控制台
;***********************************
;   0 - Black (Default background)
;   1 - Blue
;   2 - Green
;   3 - Cyan
;   4 - Red
;   5 - Magenta
;   6 - Brown
;   7 - Light grey (Default foreground)
;   8 - Dark grey
;   9 - Bright blue
;   10 - Bright green
;   11 - Bright cyan
;   12 - Bright red
;   13 - Bright magenta
;   14 - Yellow
;   15 - White


If OpenConsole()
   For Foreground = 0 To 15
      For Background = 0 To 15
         ConsoleColor(Foreground, Background)
         Print(Right(Hex(Background), 1))
      Next
      PrintN("")
    Next
    ConsoleColor(7, 0)
    PrintN("按[回车键]可以退出!")
    Input()
EndIf











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP