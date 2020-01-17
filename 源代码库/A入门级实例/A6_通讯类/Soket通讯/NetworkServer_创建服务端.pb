;***********************************
;迷路仟整理 2019.01.26
;NetworkClient_创建客户端
;***********************************

;需要运行[NetworkClient_创建客户端.pb]来来发送信息

Enumeration
   #winScreen
   #rtxNotice
   #btnConnect
EndEnumeration

#Port = 1234
Global _IsExitWindow

Procedure Thread_Server(Index)

   ServerID = CreateNetworkServer(#PB_Any, #Port)
   If ServerID = 0 
      MessageRequester("出错", "创建服务器失败!")
      ProcedureReturn
   EndIf 
   
   *MemBuffer = AllocateMemory(1024)
   Repeat
      ServerEvent = NetworkServerEvent(ServerID)
      If ServerEvent = 0 : Continue : EndIf 
      
      ClientID = EventClient()
      Select ServerEvent
         Case #PB_NetworkEvent_Connect
            AddGadgetItem(#rtxNotice, -1, "发送一个客户端: "+Str(ClientID))
            
         Case #PB_NetworkEvent_Data
            ReceiveNetworkData(ClientID, *MemBuffer, 1024)
            AddGadgetItem(#rtxNotice, -1, "接收到客户端: "+PeekS(*MemBuffer, -1, #PB_Ascii))
     
         Case #PB_NetworkEvent_Disconnect
            AddGadgetItem(#rtxNotice, -1, "客户端已经关闭: "+Str(ClientID))
            AddGadgetItem(#rtxNotice, -1, "")

      EndSelect
   Until _IsExitWindow = #True
   FreeMemory(*MemBuffer)
EndProcedure


;初始化网络插件
If InitNetwork() = 0
   MessageRequester("出错", "初始化网络插件失败!")
   End
EndIf

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "NetworkClient_创建客户端", WindowFlags)
EditorGadget(#rtxNotice, 010, 010, 380, 230)

CreateThread(@Thread_Server(), 123)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : _IsExitWindow = #True
      Case #PB_Event_Gadget
   EndSelect
   Delay(1)
Until _IsExitWindow = #True
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = 0
; EnableXP