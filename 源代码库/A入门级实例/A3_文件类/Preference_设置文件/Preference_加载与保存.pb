;***********************************
;迷路仟整理 2019.01.15
;Preference_设置文件加载与保存,支持中文标签
;***********************************

; 加载设置文件
Procedure Init_LoadPreference(PreferName$)
   OpenPreferences(PreferName$)
   PreferenceGroup("窗体设置")
      WindowX = ReadPreferenceLong("WindowX", 0)
      WindowY = ReadPreferenceLong("WindowY", 0)

   PreferenceGroup("基本信息")
      AppName$ = ReadPreferenceString("AppName", "")
      Version$ = ReadPreferenceString("Version", "")
   ClosePreferences()
EndProcedure

; 保存设置文件
Procedure Init_SavePreference(PreferName$)
   If CreatePreferences(PreferName$)
      PreferenceComment("*********************************************")
      PreferenceComment("**** 这里标识一下工具名版本作者等信息 *****")
      PreferenceComment("*********************************************")
      PreferenceGroup("基本信息")
         WritePreferenceString("AppName", AppName$)
         WritePreferenceString("Version", Version$)

      PreferenceComment("")
      PreferenceGroup("窗体设置")
         WritePreferenceLong("WindowX", WindowX)
         WritePreferenceLong("WindowY", WindowY)
      ClosePreferences()
   EndIf
EndProcedure

PreferName$ = ".\测试.ini"
Init_SavePreference(PreferName$)
Init_LoadPreference(PreferName$)

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 39
; Folding = 9
; EnableXP