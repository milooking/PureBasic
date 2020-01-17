;***********************************
;迷路仟整理 2019.01.27
;ExaminePreferenceGroups_枚举设置组
;***********************************

; 打开设置文件: [PureBasic]的设置文件
If OpenPreferences(GetHomeDirectory() + "AppData\Roaming\PureBasic\PureBasic.prefs")
   ; 枚举设置组
   ExaminePreferenceGroups()
   While NextPreferenceGroup() 
      Debug "设置组: "+ PreferenceGroupName()  ; 显示组名
   Wend
   ClosePreferences() ;关闭设置文件
EndIf 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; EnableXP