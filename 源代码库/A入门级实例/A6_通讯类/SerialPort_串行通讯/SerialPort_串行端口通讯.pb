;***********************************
;迷路仟整理 2019.01.26
;SerialPort_串行端口通讯
;***********************************

Port$ = "COM1"

SerialID = OpenSerialPort(#PB_Any, Port$, 300, #PB_SerialPort_NoParity, 8, 1, #PB_SerialPort_NoHandshake, 1024, 1024)
If SerialID
   MessageRequester("提示", "打开串行端口成功")
   CloseSerialPort(SerialID)
Else
   MessageRequester("出错", "打开串行端口失败: "+Port$)
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; EnableThread
; EnableXP