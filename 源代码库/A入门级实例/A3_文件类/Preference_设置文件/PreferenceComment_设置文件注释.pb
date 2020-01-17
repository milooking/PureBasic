;***********************************
;迷路仟整理 2019.01.27
;OpenPreferences_打开设置文件
;***********************************

If CreatePreferences(".\测试.ini")  ;创建设置文件
   PreferenceComment("*********************************************")
   PreferenceComment("**** 这里标识一下工具名版本作者等信息 *****")
   PreferenceComment("*********************************************")
   PreferenceGroup("窗体")               ;支持中文标签
      WritePreferenceLong ("X坐标", 10)  ;支持中文标签 
      WritePreferenceLong ("Y坐标", 10)  
      WritePreferenceLong ("宽度", 800)   
      WritePreferenceLong ("高度", 600)   
      WritePreferenceFloat("%", 20)    
      WritePreferenceString("标题", "设置文件演示")
   ClosePreferences()   ;关闭设置文件
EndIf 


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableXP