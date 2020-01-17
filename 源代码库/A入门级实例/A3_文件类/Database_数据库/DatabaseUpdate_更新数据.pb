;***********************************
;迷路仟整理 2019.01.31
;DatabaseUpdate_更新数据
;***********************************

UseSQLiteDatabase()                                      ;启用数据库插件

#DatabaseID = 0
FileName$ = ".\测试.sqlite"

hDatabase = OpenDatabase(#DatabaseID, FileName$, "", "") ;打开数据库
If hDatabase
   Debug "打开数据库成功!"
   If DatabaseQuery(#DatabaseID, "SELECT * FROM food") 
      Debug ""
      While NextDatabaseRow(#DatabaseID) 
         String$ = GetDatabaseString(#DatabaseID, 0)
         Debug "内容: " + String$
         DatabaseUpdate(#DatabaseID, "UPDATE food SET checked=1 WHERE id="+String$) 
      Wend
      FinishDatabaseQuery(#DatabaseID)
   EndIf
   CloseDatabase(#DatabaseID)                            ;关闭数据库
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP