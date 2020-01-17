;***********************************
;迷路仟整理 2019.01.26
;NetworkClient_创建客户端
;***********************************

;需要先运行[NetworkServer_创建服务端.pb]来创建本地服务器

Enumeration
   #winScreen
   #btnConnect
EndEnumeration

#Port = 1234
Global _SendCount

;连接成功时,发送测试内容,然后断开连接
Procedure EventGadget_Connect()
   ConnectID = OpenNetworkConnection("127.0.0.1", #Port)
   If ConnectID
      _SendCount+1
      SendNetworkString(ConnectID, "测试内容-" + Str(_SendCount), #PB_Ascii)
      CloseNetworkConnection(ConnectID)
   Else 
      MessageRequester("出错", "连接服务端失败!")
   EndIf   
EndProcedure


;初始化网络插件
If InitNetwork() = 0
   MessageRequester("出错", "初始化网络插件失败!")
   End
EndIf

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "NetworkClient_创建客户端", WindowFlags)

ButtonGadget(#btnConnect,  150, 110, 100, 030, "连接测试")
BindGadgetEvent(#btnConnect, @EventGadget_Connect())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 6
; Folding = +
; EnableXP