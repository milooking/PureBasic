;***********************************
;迷路仟整理 2019.01.31
;Database_简单实例
;***********************************

UseSQLiteDatabase()

Procedure Database_CheckUpdate(Database, Query$)
   Result = DatabaseUpdate(Database, Query$)
   If Result = 0
      Debug DatabaseError()
   EndIf
   
   ProcedureReturn Result
EndProcedure

FileName$ = ".\测试.sqlite"


FileID = CreateFile(#PB_Any, FileName$)               ;创建文件
If FileID
   Debug "创建数据库成功: " + FileName$
   CloseFile(FileID)
EndIf

DatabaseID = OpenDatabase(#PB_Any, FileName$, "", "")
If DatabaseID
   Database_CheckUpdate(DatabaseID, "CREATE TABLE food (name CHAR(50), weight INT)")
   Database_CheckUpdate(DatabaseID, "INSERT INTO food (name, weight) VALUES ('苹果', '10')")
   Database_CheckUpdate(DatabaseID, "INSERT INTO food (name, weight) VALUES ('梨',   '5' )")
   Database_CheckUpdate(DatabaseID, "INSERT INTO food (name, weight) VALUES ('香蕉', '20')")
   If DatabaseQuery(DatabaseID, "SELECT * FROM food WHERE weight > 7")  ;weight 大于7的
      While NextDatabaseRow(DatabaseID)
         Debug GetDatabaseString(DatabaseID, 0)
      Wend
      FinishDatabaseQuery(DatabaseID)
   EndIf
   
   CloseDatabase(DatabaseID)
Else
   Debug "打开数据库失败: "+FileName$
EndIf




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = +
; EnableXP