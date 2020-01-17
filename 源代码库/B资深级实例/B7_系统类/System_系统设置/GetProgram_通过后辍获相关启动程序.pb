;***********************************
;迷路仟整理 2019.03.15
;GetProgram_通过后辍获相关启动程序
;***********************************

Procedure$ GetAssociatedProgram(Extension.s) 
   KeyValue$ = Space(255) 
   Datasize.l = 255 
   AssociatedProgram$ = "" 
   If RegOpenKeyEx_(#HKEY_CLASSES_ROOT, "." + Extension, 0, #KEY_READ, @hKey)  = #ERROR_SUCCESS 
      If RegQueryValueEx_(hKey, "", 0, 0, @KeyValue$, @datasize) = #ERROR_SUCCESS 
         KeyNext.s = Left(KeyValue$, Datasize-1) 
         hKey = 0 
         KeyValue$ = Space(255) 
         Datasize.l = 255 
         If RegOpenKeyEx_(#HKEY_CLASSES_ROOT, Keynext + "\Shell\Open\Command", 0, #KEY_READ, @hKey) = #ERROR_SUCCESS 
            If RegQueryValueEx_(hKey, "", 0, 0, @KeyValue$, @datasize) = #ERROR_SUCCESS 
               AssociatedProgram$ = Left(KeyValue$, Datasize-1) 
            EndIf 
         EndIf 
      EndIf 
   EndIf 
   Pos = FindString(LCase(AssociatedProgram$), ".exe", 1) 
   If Pos <> 0 
      AssociatedProgram$ = Left(AssociatedProgram$, Pos + 4) 
      AssociatedProgram$ = ReplaceString(AssociatedProgram$, #DQUOTE$, "") 
   EndIf 
   ProcedureReturn AssociatedProgram$ 
EndProcedure 

Debug GetAssociatedProgram("doc") 
Debug GetAssociatedProgram("xls") 
Debug GetAssociatedProgram("mdb") 
Debug GetAssociatedProgram("jpg") 
Debug GetAssociatedProgram("gif") 
Debug GetAssociatedProgram("htm") 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; Folding = -
; EnableXP
; EnableOnError