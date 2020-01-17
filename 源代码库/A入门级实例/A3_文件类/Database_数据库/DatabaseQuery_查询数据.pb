;***********************************
;迷路仟整理 2019.01.31
;DatabaseQuery_查询数据
;***********************************

UseSQLiteDatabase()                                      ;启用数据库插件

#DatabaseID = 0
FileName$ = ".\测试.sqlite"

hDatabase = OpenDatabase(#DatabaseID, FileName$, "", "") ;打开数据库
If hDatabase
   Debug "打开数据库成功!"
   If DatabaseQuery(#DatabaseID, "SELECT * FROM food") 
      Debug "查询表格[food]成功!"
      While NextDatabaseRow(#DatabaseID) 
         Debug "内容: " + GetDatabaseString(#DatabaseID, 0)
      Wend
      FinishDatabaseQuery(#DatabaseID)                   ;关闭查询
   EndIf
   CloseDatabase(#DatabaseID)                            ;关闭数据库
EndIf





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; FirstLine = 2
; EnableXP