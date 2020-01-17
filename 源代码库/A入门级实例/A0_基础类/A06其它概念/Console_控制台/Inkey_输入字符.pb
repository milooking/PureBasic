;***********************************
;迷路仟整理 2019.01.29
;Inkey_输入字符
;***********************************


If OpenConsole()
   PrintN("按[ESC]退出")
   Repeat
      KeyPressed$ = Inkey()
      If KeyPressed$ <> ""
         PrintN("输入字符 : " + KeyPressed$)
         PrintN("按键KEY值: "+Str(RawKey()))
      ElseIf RawKey()
         PrintN("按下非ASCII键.")
         PrintN("按键KEY值: "+Str(RawKey()))
      Else
         Delay(20) 
      EndIf
   Until KeyPressed$ = Chr(27)
EndIf















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP