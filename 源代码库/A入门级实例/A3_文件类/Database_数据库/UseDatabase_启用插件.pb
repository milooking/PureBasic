;***********************************
;迷路仟整理 2019.01.31
;UseDatabase_启用插件
;***********************************

; UseODBCDatabase()
; UseSQLiteDatabase()
; UsePostgreSQLDatabase()


UseSQLiteDatabase()                                   ;启用数据库插件

FileName$ = ".\测试.sqlite"
FileID = CreateFile(#PB_Any, FileName$)               ;创建文件
If FileID
   Debug "创建数据库成功: " + FileName$
   CloseFile(FileID)
EndIf
  
DatabaseID = OpenDatabase(#PB_Any, FileName$, "", "") ;打开数据库
If DatabaseID
   Debug "打开数据库: " + FileName$
   If DatabaseUpdate(DatabaseID, "CREATE TABLE info (test VARCHAR(255));")
      Debug "创建: info"
   EndIf
   CloseDatabase(DatabaseID)                          ;关闭数据库
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; FirstLine = 4
; EnableXP