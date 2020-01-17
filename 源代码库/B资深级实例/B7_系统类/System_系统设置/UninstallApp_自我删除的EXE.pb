;***********************************
;迷路仟整理 2019.03.15
;UninstallApp_自我删除的EXE
;***********************************
;不支持中文路径和中文EXE名称.

Procedure UninstallApp()
   AppName$ = Space(256)
   GetModuleFileName_(GetModuleHandle_(0), @AppName$, 256)
   FileID = OpenFile(#PB_Any,Left(AppName$,1) +":\~~uninst.bat" )
   If FileID
      WriteStringFormat(FileID,#PB_Ascii)
      WriteStringN(FileID, " :DeleteFile")
      WriteStringN(FileID, "del " + AppName$)
      WriteStringN(FileID, "if exist " + AppName$ + " goto StillExists")
      WriteStringN(FileID, "del " + Left(AppName$, 1) + ":\~~uninst.bat")
      WriteStringN(FileID, "exit")
      WriteStringN(FileID, ":StillExists")
      WriteStringN(FileID, "goto DeleteFile")
      CloseFile(FileID)
      Result= RunProgram(Left(AppName$, 1) + ":\~~uninst.bat","","",2)
   EndIf
   MessageRequester("提示","点击后程序进行自杀: "+#LFCR$ +AppName$)
EndProcedure

UninstallApp()



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; Folding = -
; EnableXP
; EnableOnError
; Executable = KillMe.exe