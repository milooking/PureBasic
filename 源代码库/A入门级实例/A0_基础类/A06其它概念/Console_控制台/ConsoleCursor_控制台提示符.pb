;***********************************
;迷路仟整理 2019.01.29
;ConsoleCursor_控制台提示符
;***********************************
;   1 : Underline cursor (Default)
;   5 : Mid-height cursor
;   10: Full-height cursor


If OpenConsole()
   EnableGraphicalConsole(1)
   For CursorHeight = 1 To 10 Step 3
      ConsoleCursor(CursorHeight)
      PrintN("按回车键增加光标大小")
      Input()
   Next
    
   PrintN("按[回车键]可以退出!")
   Input()
EndIf












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; EnableXP