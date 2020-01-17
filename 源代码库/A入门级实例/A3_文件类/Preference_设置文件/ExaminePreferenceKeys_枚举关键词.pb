;***********************************
;迷路仟整理 2019.01.27
;ExaminePreferenceKeys_枚举关键词.pb
;***********************************

; 打开设置文件: [PureBasic]的设置文件
If OpenPreferences(GetHomeDirectory() + "AppData\Roaming\PureBasic\PureBasic.prefs")
   ; 枚举设置组
   ExaminePreferenceGroups()
   While NextPreferenceGroup()
      Debug "" 
      Debug "设置组: "+ PreferenceGroupName()  ; 显示组名
      ExaminePreferenceKeys()
      While  NextPreferenceKey() 
         Debug "   关键词: " + PreferenceKeyName() + " = " + PreferenceKeyValue()
      Wend
   Wend
   ClosePreferences() ;关闭设置文件
EndIf 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; EnableXP