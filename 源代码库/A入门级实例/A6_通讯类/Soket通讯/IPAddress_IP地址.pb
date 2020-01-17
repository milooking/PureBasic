;***********************************
;迷路仟整理 2019.01.26
;IPAddress_IP地址
;***********************************

;MakeIPAddress(Field0,Field1,Field2,Field3)相当于: Field3<<24|Field2<<16|Field1<<18|Field0

IPAddress = MakeIPAddress(127, 0, 0, 1) 
IPValue   =  1<<24|0<<16|0<<8|127
Debug "IP地址(127.0.0.1) = 0x"+Hex(IPAddress, #PB_Long)
Debug "IP地址(127.0.0.1) = 0x"+Hex(IPValue, #PB_Long)


InitNetwork()
IPString$ = IPString(IPAddress) 
Debug ""
Debug "IP地址 = " + IPString$


Debug ""
InitNetwork()
If ExamineIPAddresses()
   Repeat
      IPAddress = NextIPAddress()
      If IPAddress
        Debug "主机IP: " + IPString(IPAddress) 
      EndIf
   Until IPAddress = 0
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 27
; FirstLine = 4
; EnableXP