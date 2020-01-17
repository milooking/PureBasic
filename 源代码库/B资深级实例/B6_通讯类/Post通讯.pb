;***********************************
;迷路仟整理 2019.01.15
;按键事件
;***********************************

Procedure$ PostNetwork_HTTP(PostText$)
   IsLoop.b = #True
    
   hInternet = InternetOpen_("PB@INET", 1, #Null, #Null, 0)  
   If hInternet
      hOpenUrl = InternetOpenUrl_(hInternet, PostText$, #Null, 0, $80000000, 0)  
      If hOpenUrl
         *MemData =AllocateMemory(20480) 
         Repeat  
            Delay(1)  
            InternetReadFile_(hOpenUrl, *MemData, 20480, @Bytes)  
            If Bytes = 0 
               IsLoop=#False  
            Else 
               LineText$ = PeekS(*MemData, Bytes, #PB_UTF8)
               IsLoop=#False 
            EndIf  
         Until IsLoop=#False  
         InternetCloseHandle_(hOpenUrl) 
         FreeMemory(*MemData)
      EndIf 
      InternetCloseHandle_(hInternet)
   EndIf 
   ProcedureReturn  LineText$
EndProcedure

Procedure$ PostNetwork_JSON(PostText$, ServerIP$, PortNum)
   PostText$ = ReplaceString(PostText$, "'", #DQUOTE$)
   Header$ = "POST / HTTP/1.1" + #CRLF$
   Header$ + "Host: "+ServerIP$ + #CRLF$   ;IP+":"+端口
   Header$ + "Content-Type: application/x-www-form-urlencoded" + #CRLF$
   Header$ + "Content-Length: " + Str(Len(PostText$)) + #CRLF$
   Header$ + #CRLF$
   Debug Header$
   ConnectID = OpenNetworkConnection(ServerIP$, PortNum)  
   If ConnectID 
      SendNetworkString(ConnectID, Header$+PostText$, #PB_Ascii)  
      While NetworkClientEvent(ConnectID) <> 2 And Index < 3000 ;30秒
         Index+1 : Delay(10)  
      Wend 
      If Index < 3000 
         RecvSize = 100000  
         *MemDecv = AllocateMemory(RecvSize)  
         While Lenght = 0
            Lenght = ReceiveNetworkData(ConnectID, *MemDecv, RecvSize) 
            If Lenght <= 65536
               LineText$ + PeekS(*MemDecv, Lenght, #PB_Ascii)
            EndIf 
         Wend  
         FreeMemory(*MemDecv)  
      EndIf 
      CloseNetworkConnection(ConnectID)  
   EndIf 
   ProcedureReturn LineText$
EndProcedure

InitNetwork()
Debug PostNetwork_HTTP("Https://www.purebasic.fr/english/search.php")
















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 66
; Folding = 9
; EnableXP