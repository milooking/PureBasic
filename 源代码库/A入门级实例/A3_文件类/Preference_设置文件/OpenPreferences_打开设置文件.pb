;***********************************
;迷路仟整理 2019.01.27
;OpenPreferences_打开设置文件
;***********************************

;这里不使用IF,作用是,即使没有设置文件,也可以根据默认进行加载
OpenPreferences(".\测试.ini")  ;创建设置文件
   PreferenceGroup("窗体")               ;支持中文标签
      Debug "X坐标 = " + ReadPreferenceLong ("X坐标", 10)  ;采用默认值,如果没有这个关键词,会自动启用默认值
      Debug "Y坐标 = " + ReadPreferenceLong ("Y坐标", 10)  
      Debug "宽度  = " + ReadPreferenceLong ("宽度", 800)   
      Debug "高度  = " + ReadPreferenceLong ("高度", 600)   
      Debug "百分比= " + ReadPreferenceFloat("百分比", 20)    
      Debug "标题  = " + ReadPreferenceString("标题", "设置文件演示")
   ClosePreferences()   ;关闭设置文件




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Markers = 19
; EnableXP