;***********************************
;迷路仟整理 2019.01.31
;DatabaseError_出错提示
;***********************************

UseSQLiteDatabase()                                   ;启用数据库插件

#DatabaseID = 0
FileName$ = ".\测试.sqlite"


hDatabase = OpenDatabase(#DatabaseID, FileName$, "", "") ;打开数据库
If hDatabase
   If DatabaseQuery(#DatabaseID, "SELECT * FROM employee") 
      FinishDatabaseQuery(#DatabaseID)
   Else
      MessageRequester("", "出错提示: "+DatabaseError())
   EndIf

   CloseDatabase(#DatabaseID)                          ;关闭数据库
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; EnableXP